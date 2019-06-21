Return-Path: <SRS0=K8vK=UU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E97EDC43613
	for <linux-pci@archiver.kernel.org>; Fri, 21 Jun 2019 23:15:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1CBE208CA
	for <linux-pci@archiver.kernel.org>; Fri, 21 Jun 2019 23:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561158957;
	bh=UsUK6BcgifrsKuTNAhqJUC3cA2uP1+uOK9k3Xj/O2Dg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tmUAsdIqwyJyqRtV1IRhg+fVd58LN7jpoRHm7BJ7rrFi5joi1tC1VqnzDnR93M0AJ
	 Ceb9Q3sdHqNURqw8aYf75U/OC3YhOoSLF/MJfAmdJ0bv2+NPqU61OYiAX4UOP0YJaW
	 2zJwNN001sLzh9XbjBYP5h1UDV4YpTmNNwLHa4IY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbfFUXP5 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 21 Jun 2019 19:15:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:39472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726043AbfFUXP4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 21 Jun 2019 19:15:56 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05CE42089E;
        Fri, 21 Jun 2019 23:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561158956;
        bh=UsUK6BcgifrsKuTNAhqJUC3cA2uP1+uOK9k3Xj/O2Dg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ngKEYUmt4jw8+l9KnRKjVUC3YBuHElaIufqBDzqH3DxUhB5t3XMBoADfmqqJsR1i4
         KIkqdOlaRMzD2kv9myOrPSS4hWfEoJlB1orwKZk4GO2xPwok+pmGtifozXJK5lm7iA
         2K+YDkwbcAQ/lD97RnUtgvTb16wthwA5vs3ngYbE=
Date:   Fri, 21 Jun 2019 18:15:51 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linux-pci@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sinan Kaya <okaya@kernel.org>, Ali Saidi <alisaidi@amazon.com>,
        Zeev Zilberman <zeev@amazon.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 1/4] arm64: pci: acpi: Use
 pci_assign_unassigned_root_bus_resources()
Message-ID: <20190621231551.GG127746@google.com>
References: <20190615002359.29577-1-benh@kernel.crashing.org>
 <20190621204839.GF127746@google.com>
 <43b27f7fc83a90dc3d1345ee3771fcce337f6bb8.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43b27f7fc83a90dc3d1345ee3771fcce337f6bb8.camel@kernel.crashing.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Jun 22, 2019 at 09:00:50AM +1000, Benjamin Herrenschmidt wrote:
> BTW...
> 
> You probably want to swap those 2:
> 
> 2 hours	PCI/ACPI: Evaluate PCI Boot Configuration _DSM	Benjamin Herrenschmidt	3	-3/+18
> 2 hours	PCI: Don't auto-realloc if we're preserving firmware config
> 
> As "Don't auto-realloc..." tests a flag that is only created by "Evaluate PCI Boot..."

Ouch, thanks.  I don't know how I managed to swap those.
