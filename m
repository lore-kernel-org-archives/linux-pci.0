Return-Path: <SRS0=WZ4f=NE=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5FB0C004D3
	for <linux-pci@archiver.kernel.org>; Wed, 24 Oct 2018 13:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 537D52082E
	for <linux-pci@archiver.kernel.org>; Wed, 24 Oct 2018 13:49:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZS241srZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 537D52082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbeJXWSB (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 24 Oct 2018 18:18:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:48326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726285AbeJXWSB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 24 Oct 2018 18:18:01 -0400
Received: from localhost (173-25-171-118.client.mchsi.com [173.25.171.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B4092064A;
        Wed, 24 Oct 2018 13:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540388988;
        bh=AjQ1WDcYwm6zy7P43iwDrOzc7O4/XMyqCemfoAliZZc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZS241srZ/bOhj3A5WuAETxI4ZJK5A3pgaA0WXN+MfAjQhhyzdZIu/6wvmm3x/kp9j
         bbahfu3nwl2VwKE61+51DhxG+lHbBUIlOUqqFXoNPVvpwSnjKwAEXHlfEj17oT8hSV
         4UseVtTak03EaL48KI3EXzveTXtZ/2WeqnxWiHjo=
Date:   Wed, 24 Oct 2018 08:49:47 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Meelis Roos <mroos@linux.ee>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org
Subject: Re: HH DL585 warm boot fail (old)
Message-ID: <20181024134946.GA214775@bhelgaas-glaptop.roam.corp.google.com>
References: <alpine.LRH.2.21.1807051515260.21817@math.ut.ee>
 <CAErSpo6Fp8XpTQi7gcSQEuvpuJMYCMn5Y0cXRNvmO_opSR08HQ@mail.gmail.com>
 <b36c537a-90ee-c474-9efa-df2ead8e0376@linux.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b36c537a-90ee-c474-9efa-df2ead8e0376@linux.ee>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 24, 2018 at 10:47:24AM +0300, Meelis Roos wrote:
> > Would you mind opening a report at https://bugzilla.kernel.org?  I'm
> > not sure if anybody will be able to do anything about this, but it's
> > always possible.
> 
> Submitted now, https://bugzilla.kernel.org/show_bug.cgi?id=201503
> 
> > A complete dmesg log and "sudo lspci -vv" output from a successful
> > boot would be a good start.  And if you have a screenshot of the
> > failure, that would help, too.  You can use the "ignore_loglevel"
> > kernel parameter to make sure we see everything on the console.
> 
> Added.
> 
> >  Does this machine have an iLO?  If so, it may have logs that
> >  could be useful if this is related to some sort of bus error.
> 
> Nothing in the ILO logs.

Great, thanks!

Can you try the patch below?  This is extracted from the code here:
https://github.com/joyent/illumos-joyent/blob/b6a0b04d591f5b877cfe05f45e81f0e8a5cfc2b3/usr/src/uts/intel/io/pci/pci_boot.c#L1805

I'm not sure why this would be only an intermittent problem, but at
least we can see if this is related.


diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 6bc27b7fd452..842f900ed194 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5113,3 +5113,15 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_MICROSEMI, 0x8575,
 			quirk_switchtec_ntb_dma_alias);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_MICROSEMI, 0x8576,
 			quirk_switchtec_ntb_dma_alias);
+
+static void quirk_amd_8111(struct pci_dev *pdev)
+{
+	u8 ioc;
+
+	pci_read_config_byte(pdev, 0x40, &ioc);
+	if (ioc & 0x80) {
+		pci_info(pdev, "disabling NMI on error\n");
+		pci_write_config_byte(pdev, 0x40, ioc & ~0x80);
+	}
+}
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x7468, quirk_amd_8111);
