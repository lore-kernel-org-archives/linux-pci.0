Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f172.google.com ([209.85.214.172]:53341 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751690Ab3FJQ7e (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 10 Jun 2013 12:59:34 -0400
Received: by mail-ob0-f172.google.com with SMTP id wo10so10500285obc.31
        for <linux-pci@vger.kernel.org>; Mon, 10 Jun 2013 09:59:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1370749669-20348-1-git-send-email-wangyijing@huawei.com>
References: <1370749669-20348-1-git-send-email-wangyijing@huawei.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 10 Jun 2013 10:59:13 -0600
Message-ID: <CAErSpo5RAC7eitUnw0-FFzq463DjwCEy---RHqEC912UJGa5SQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: Fix comment typo for pcie_pme_remove()
To: Yijing Wang <wangyijing@huawei.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Jiang Liu <jiang.liu@huawei.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Jun 8, 2013 at 9:47 PM, Yijing Wang <wangyijing@huawei.com> wrote:
> Fix trivial comment typo for pcie_pme_remove().
>
> Signed-off-by: Yijing Wang <wangyijing@huawei.com>

Applied to pci/misc for v3.11, thanks.

> ---
>  drivers/pci/pcie/pme.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/pci/pcie/pme.c b/drivers/pci/pcie/pme.c
> index 795db1f..e56e594 100644
> --- a/drivers/pci/pcie/pme.c
> +++ b/drivers/pci/pcie/pme.c
> @@ -408,7 +408,7 @@ static int pcie_pme_resume(struct pcie_device *srv)
>
>  /**
>   * pcie_pme_remove - Prepare PCIe PME service device for removal.
> - * @srv - PCIe service device to resume.
> + * @srv - PCIe service device to remove.
>   */
>  static void pcie_pme_remove(struct pcie_device *srv)
>  {
> --
> 1.7.1
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
