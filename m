Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f171.google.com ([209.85.213.171]:40502 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965683AbaGPSIy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 16 Jul 2014 14:08:54 -0400
Received: by mail-ig0-f171.google.com with SMTP id l13so4444052iga.16
        for <linux-pci@vger.kernel.org>; Wed, 16 Jul 2014 11:08:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1405498124-11519-1-git-send-email-qiudayu@linux.vnet.ibm.com>
References: <1405498124-11519-1-git-send-email-qiudayu@linux.vnet.ibm.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 16 Jul 2014 12:08:30 -0600
Message-ID: <CAErSpo47WBkOuThU6ZW0htSm9s2P_r0ebZ6T3TM0dWiSdaGaBA@mail.gmail.com>
Subject: Re: [PATCH] Fix build warnings in aer.h
To: Mike Qiu <qiudayu@linux.vnet.ibm.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jul 16, 2014 at 2:08 AM, Mike Qiu <qiudayu@linux.vnet.ibm.com> wrote:
> build log:
>
> In file included from include/ras/ras_event.h:11:0,
>                  from drivers/ras/ras.c:13:
> include/linux/aer.h:42:129: warning: ‘struct pci_dev’
> declared inside parameter list [enabled by default]
>
> include/linux/aer.h:42:129: warning: its scope is only
> this definition or declaration, which is probably not
> what you want [enabled by default]
>
> include/linux/aer.h:46:130: warning: ‘struct pci_dev’
> declared inside parameter list [enabled by default]
>
> include/linux/aer.h:50:136: warning: ‘struct pci_dev’
> declared inside parameter list [enabled by default]
>
> include/linux/aer.h:57:14: warning: ‘struct pci_dev’
> declared inside parameter list [enabled by default]
>
> Signed-off-by: Mike Qiu <qiudayu@linux.vnet.ibm.com>

Hi Mike,

How did you reproduce this build error?  There are other include files
that use pci_dev without a previous declaration or include of
include/linux/pci.h, e.g., include/linux/msi.h, so I want to make sure
we don't have similar problems elsewhere.

Bjorn

> ---
>  include/linux/aer.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/include/linux/aer.h b/include/linux/aer.h
> index 4dbaa70..c826d1c 100644
> --- a/include/linux/aer.h
> +++ b/include/linux/aer.h
> @@ -11,6 +11,8 @@
>  #define AER_FATAL                      1
>  #define AER_CORRECTABLE                        2
>
> +struct pci_dev;
> +
>  struct aer_header_log_regs {
>         unsigned int dw0;
>         unsigned int dw1;
> --
> 1.8.1.4
>
