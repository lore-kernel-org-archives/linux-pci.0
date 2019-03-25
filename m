Return-Path: <SRS0=Cb4Y=R4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA7F7C43381
	for <linux-pci@archiver.kernel.org>; Mon, 25 Mar 2019 17:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA4C221473
	for <linux-pci@archiver.kernel.org>; Mon, 25 Mar 2019 17:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553535416;
	bh=Rg08QyK2vOPJcNoTgP9Jxsy+bxhC3JF1GS7obQA93kI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JJfjWiIAxEYPdQiBg6H3hEIYIVJ8ELLsw2im4fe62JVlSg0JCsRuaYjozn3NMYQ2J
	 pBFfV3UrYzdqjIVmgZjIxWX5xUCq5isu8W1NRluzKy3e7XSqn4JAXUz6+K8HnwMnqm
	 eczz684KAhqxaCfLyvohq8ZBV5eJzwL2iTfL9ldQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728991AbfCYRg4 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 25 Mar 2019 13:36:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:34894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726217AbfCYRgz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 25 Mar 2019 13:36:55 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A67E4205C9;
        Mon, 25 Mar 2019 17:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553535415;
        bh=Rg08QyK2vOPJcNoTgP9Jxsy+bxhC3JF1GS7obQA93kI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Kqmcc/JxMJl1JvbDlPirFfgBNljY6znGfT6EFD3f5jSUfc8xCgeWOpKeKE1CHMQBJ
         JDhlKhWNL998c4MELZHgnDcmakEtcJ/iv7DrDdu1GeEiIp+OWHWifkssppuexRjoff
         o+PsZkdOrIDHH6kdFZMrE/7fayLGZDWkbh4JSt4A=
Date:   Mon, 25 Mar 2019 12:36:47 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jonathan Chocron <jonnyc@amazon.com>
Cc:     linux-pci@vger.kernel.org, lorenzo.pieralisi@arm.com,
        linux-kernel@vger.kernel.org, vaerov@amazon.com, dwmw@amazon.co.uk,
        benh@kernel.crashing.org, alisaidi@amazon.com, zeev@amazon.com,
        ronenk@amazon.com, barakw@amazon.com,
        Talel Shenhar <talel@amazon.com>
Subject: Re: [PATCH] PCI: al: add pcie-al.c
Message-ID: <20190325173646.GR251185@google.com>
References: <1553512040-4453-1-git-send-email-jonnyc@amazon.com>
 <20190325125832.GP251185@google.com>
 <f2c79fae-d35c-a17f-8b5c-d2404ff067a0@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2c79fae-d35c-a17f-8b5c-d2404ff067a0@amazon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 25, 2019 at 05:56:35PM +0200, Jonathan Chocron wrote:
> On 3/25/19 14:58, Bjorn Helgaas wrote:

> > I think you're actually looking for a AMZN0001 device, not a PNP0C02
> > device.  Your firmware might have a PNP0C02 _HID and AMZN0001 _CID, but
> > that's not relevant here since you're only filtering by AMZN0001.
> > 
> Actually, the _HID is AMZN0001 and the _CID is PNP0C02, so that's why
> I used PNP0C02 (to state that it is of this "type"). Please let me know if
> you still think it should be changed, so I'll integrate it into v2.

I do still think it should be changed, because there's nothing in the
code that refers to PNP0C02.  That _CID could be absent or could
contain any other ID and it wouldn't make any difference to the
driver.  But if there's no device with _HID or _CID of AMZN0001, the
driver will fail.

Bjorn
