Return-Path: <SRS0=/keI=R5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B94C43381
	for <linux-pci@archiver.kernel.org>; Tue, 26 Mar 2019 12:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31A1D20823
	for <linux-pci@archiver.kernel.org>; Tue, 26 Mar 2019 12:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553604912;
	bh=zwrszH0q56mIPC28FXfodGT4P/TQFSU0NFXDHwmLx/w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uXW841xFrN2O68g8LCPBbLMVaBLvXFOK7DBTj1j2MAgkhLJNtF7aD9rkLnOTpYlLN
	 fAlAHGw+TGTGQqDA/q8xq54h7O9nvaz/0A2rqozXpXSfJae+T1WB2b7oX0UQSoEWMR
	 /ztu0AbDp15ttX6L4oHRx0HPwqzfTpmEGFJTA0Fg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726258AbfCZMzL (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 26 Mar 2019 08:55:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:33152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726241AbfCZMzL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 26 Mar 2019 08:55:11 -0400
Received: from localhost (173-25-63-173.client.mchsi.com [173.25.63.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 221562070B;
        Tue, 26 Mar 2019 12:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553604910;
        bh=zwrszH0q56mIPC28FXfodGT4P/TQFSU0NFXDHwmLx/w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZshjX7/kTWgu3JyqjG2xr7Y8OmvqDo35udLb4fRzMsCvP9EuJvZEJUuivNuC398ws
         g+m2ztv0y0EWc1BOoKsrZGsB8SFSGUZ7r2Q+z1uLuBE/XiBgAYAEcxRXlS8wbNI2jJ
         0Njhf5IUXJcOYfPJtUbGcbblriCvOhWbrOTsrbAY=
Date:   Tue, 26 Mar 2019 07:55:08 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jonathan Chocron <jonnyc@amazon.com>
Cc:     linux-pci@vger.kernel.org, lorenzo.pieralisi@arm.com,
        linux-kernel@vger.kernel.org, vaerov@amazon.com, dwmw@amazon.co.uk,
        benh@kernel.crashing.org, alisaidi@amazon.com, zeev@amazon.com,
        ronenk@amazon.com, barakw@amazon.com
Subject: Re: [PATCH v2] PCI: al: Add Amazon Annapurna Labs PCIe host
 controller driver
Message-ID: <20190326125508.GG24180@google.com>
References: <1553512040-4453-1-git-send-email-jonnyc@amazon.com>
 <1553594455-30436-1-git-send-email-jonnyc@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1553594455-30436-1-git-send-email-jonnyc@amazon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Nits, probably Lorenzo will fix them up unless he sees more substantive
things.

On Tue, Mar 26, 2019 at 12:00:55PM +0200, Jonathan Chocron wrote:
> Adding support for Amazon's Annapurna Labs PCIe driver.

Ideally, use "imperative mood", i.e., write it as a command:

  Add support for Amazon's Annapurna Labs PCIe driver.

> The HW controller is based on DesignWare's IP.
> 
> The HW doesn't support accessing the Root Port's config space via
> ECAM, so we obtain its base address via an AMZN0001 device.
> 
> Furthermore, the DesignWare PCIe controller doesn't filter out
> config transactions sent to devices 1 and up on its bus, so they
> are filtered by the driver.
> All subordinate buses do support ECAM access.

I didn't communicate my point very clearly.  The above four lines
should either be (1) a single paragraph, wrapped to fill the entire
width, or (2) two paragraphs, with a blank line before "All
subordinate buses ..."

The fact that "... by the driver" ends in the middle of the line
suggests that it's the end of the paragraph, but the fact that there's
no blank line following suggests that it's not.  So it creates an
unnecessary hiccup for the reader.

> Implementing specific PCI config access functions involves:
>  - Adding an init function to obtain the Root Port's base address
>    from an AMZN0001 device.
>  - Adding a new entry in the mcfg quirk array

s/mcfg/MCFG/ since "MCFG" is an ACPI table ID, not a word.

Bjorn
