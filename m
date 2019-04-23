Return-Path: <SRS0=Emu/=SZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB866C10F03
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 17:57:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B09AC217D9
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 17:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556042250;
	bh=i+ev8JPjUW7MLW+XuORY0kfNzW74fTPiN/jD9asD+Qc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zMOdxj8yuz7FrBCH4AF9KuOfsYSvhl7QPZFUYrIzmMx6V8y/KJfm5Z0nN0cnGBSDj
	 TInrsjKF7MXkZi+t1TDEUwEECNR/JIkG/HN1AEKa5csTCTmMsn+2msoaeLWtMGNm6a
	 rN9CzIBNF53ve+fPL8UphFpcyixHO6qe4R23Y4tI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727745AbfDWR5a (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 23 Apr 2019 13:57:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:40406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726655AbfDWR5a (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 23 Apr 2019 13:57:30 -0400
Received: from localhost (odyssey.drury.edu [64.22.249.253])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E97B920835;
        Tue, 23 Apr 2019 17:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556042249;
        bh=i+ev8JPjUW7MLW+XuORY0kfNzW74fTPiN/jD9asD+Qc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jjz1Ulx6Au6gfXpzS5rhCkm5+6LjjWS9osUn7wiSeQp7K7Ny1RvnSBIyu8TMq7qKs
         r8PgwKZFjoA8/Trx0q48FnoYr/+KFG1uy1zy6eobDnkqC/2X/7bw9Y6ZQjFJpJHKz2
         ZteOHCu/dQ7PSM33OVRPnbcuahpU4JizL9T6zssU=
Date:   Tue, 23 Apr 2019 12:57:28 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     kbuild test robot <lkp@intel.com>
Cc:     Alexandru Gagniuc <mr.nuke.me@gmail.com>, kbuild-all@01.org,
        linux-pci@vger.kernel.org
Subject: Re: [pci:pci/hotplug 4/5] (.text+0x3454): multiple definition of
 `pci_acpi_program_hp_params'
Message-ID: <20190423175728.GB14616@google.com>
References: <201904230807.LpFL2omo%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201904230807.LpFL2omo%lkp@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 23, 2019 at 08:09:08AM +0800, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/hotplug
> head:   c098676c4df695cc8f430bfa5fa803f41c8584f4
> commit: 8c76b06f58183e15f31d6660c9bd049cbba9e4f6 [4/5] PCI / ACPI: Remove the need for 'struct hotplug_params'
> config: riscv-allyesconfig (attached as .config)
> compiler: riscv64-linux-gcc (GCC) 8.1.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout 8c76b06f58183e15f31d6660c9bd049cbba9e4f6
>         # save the attached .config to linux build tree
>         GCC_VERSION=8.1.0 make.cross ARCH=riscv 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/pci/pci.o: In function `pci_acpi_program_hp_params':
> >> (.text+0x3454): multiple definition of `pci_acpi_program_hp_params'
>    drivers/pci/probe.o:(.text+0x864): first defined here

I fixed this by making the non-ACPI stub of
pci_acpi_program_hp_params() a "static inline" function:

diff --git a/include/linux/pci_hotplug.h b/include/linux/pci_hotplug.h
index 352c5169c256..f694eb2ca978 100644
--- a/include/linux/pci_hotplug.h
+++ b/include/linux/pci_hotplug.h
@@ -188,8 +188,8 @@ bool shpchp_is_native(struct pci_dev *bridge);
 int acpi_pci_check_ejectable(struct pci_bus *pbus, acpi_handle handle);
 int acpi_pci_detect_ejectable(acpi_handle handle);
 #else
-int pci_acpi_program_hp_params(struct pci_dev *dev,
-			       const struct hotplug_program_ops *hp_ops)
+static inline int pci_acpi_program_hp_params(struct pci_dev *dev,
+				    const struct hotplug_program_ops *hp_ops)
 {
 	return -ENODEV;
 }
