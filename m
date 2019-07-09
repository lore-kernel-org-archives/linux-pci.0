Return-Path: <SRS0=0Iuk=VG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 236C5C48BE7
	for <linux-pci@archiver.kernel.org>; Tue,  9 Jul 2019 11:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC11D214AF
	for <linux-pci@archiver.kernel.org>; Tue,  9 Jul 2019 11:48:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="VvDLdjd3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726025AbfGILsB (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 9 Jul 2019 07:48:01 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:48966 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbfGILsB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 Jul 2019 07:48:01 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x69BlS4G030720;
        Tue, 9 Jul 2019 06:47:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1562672848;
        bh=QkqcskFZE5RYkKqs+6UIPK6Ypsi+eJYHWDnX57nl558=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=VvDLdjd34L1IA85TVh2USL5lUX+7zNX2Twj1hu76hxwFAUhvO2dIm4sGI9TWqIjsN
         z/QYVZFfy0FjsrMgXel6fl+Ay+nT5ung/tWCdVw8KCb2MjBnmwjmgo/6z9DzFms/3f
         a+I20FJmW20yoZfpDeWxS6S6ycwaycbFzQ3PBdac=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x69BlSR1082642
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 9 Jul 2019 06:47:28 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 9 Jul
 2019 06:47:28 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 9 Jul 2019 06:47:28 -0500
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x69BlN0Y063752;
        Tue, 9 Jul 2019 06:47:25 -0500
Subject: Re: [PATCH v1] tools: PCI: Fix installation when `make
 tools/pci_install`
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        <linux-pci@vger.kernel.org>
CC:     Jean-Jacques Hiblot <jjhiblot@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
References: <20190628133326.18203-1-andriy.shevchenko@linux.intel.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <b7199693-9426-2ab6-4a95-20ebed5fdf71@ti.com>
Date:   Tue, 9 Jul 2019 17:15:44 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190628133326.18203-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Andy,

On 28/06/19 7:03 PM, Andy Shevchenko wrote:
> The commit c9a707875053 ("tools pci: Do not delete pcitest.sh in 'make clean'")
> fixed a `make tools clean` issue and simultaneously brought a regression
> to the installation process:
> 
>   for script in .../tools/pci/pcitest.sh; do	\
> 	install $script .../usr/usr/bin;	\
>   done
>   install: cannot stat '.../tools/pci/pcitest.sh': No such file or directory
> 
> Here is the missed part of the fix.
> 
> Cc: Jean-Jacques Hiblot <jjhiblot@ti.com>
> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  tools/pci/Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/pci/Makefile b/tools/pci/Makefile
> index 6876ee4bd78c..cc4a161ee2cc 100644
> --- a/tools/pci/Makefile
> +++ b/tools/pci/Makefile
> @@ -47,10 +47,10 @@ clean:
>  
>  install: $(ALL_PROGRAMS)
>  	install -d -m 755 $(DESTDIR)$(bindir);		\
> -	for program in $(ALL_PROGRAMS) pcitest.sh; do	\
> +	for program in $(ALL_PROGRAMS); do		\
>  		install $$program $(DESTDIR)$(bindir);	\
>  	done;						\
> -	for script in $(ALL_SCRIPTS); do		\
> +	for script in pcitest.sh; do			\

If ALL_SCRIPTS is not used anywhere else, this patch can remove that as well.
With that fixed

Acked-by: Kishon Vijay Abraham I <kishon@ti.com>

Thanks
Kishon
