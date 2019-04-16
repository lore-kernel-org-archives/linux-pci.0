Return-Path: <SRS0=aMvC=SS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA03C10F13
	for <linux-pci@archiver.kernel.org>; Tue, 16 Apr 2019 10:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43E942075B
	for <linux-pci@archiver.kernel.org>; Tue, 16 Apr 2019 10:49:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="MXmROrMJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbfDPKtJ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 16 Apr 2019 06:49:09 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:19854 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbfDPKtJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Apr 2019 06:49:09 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cb5b3280000>; Tue, 16 Apr 2019 03:49:12 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 16 Apr 2019 03:49:07 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 16 Apr 2019 03:49:07 -0700
Received: from [10.24.45.163] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 16 Apr
 2019 10:49:03 +0000
Subject: Re: [PATCH V2] PCI: tegra: Use the DMA-API to get the MSI address
To:     Robin Murphy <robin.murphy@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     <bhelgaas@google.com>, <treding@nvidia.com>, <swarren@nvidia.com>,
        <mperttunen@nvidia.com>, <jonathanh@nvidia.com>, <dev@lynxeye.de>,
        <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>
References: <1553004121-24606-1-git-send-email-vidyas@nvidia.com>
 <20190411094024.GC6227@red-moon>
 <ed7456f7-df3f-c812-d177-e95c9c5f6868@arm.com>
X-Nvconfidentiality: public
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <7d9ecd44-36a7-befb-621f-1e30ef8c69bd@nvidia.com>
Date:   Tue, 16 Apr 2019 16:18:46 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <ed7456f7-df3f-c812-d177-e95c9c5f6868@arm.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1555411752; bh=ONbEL5AFFXMOuTEoetcSzlVZs0Drbxqhe8FSI7EiSD0=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=MXmROrMJS/0cauPR5IqSXYRn37dJyFNpQcMPqwijsvrK+A2Pa/pRDo44NU8O/hGK4
         I8yamL3/A4L1b2PqP3FmcmioMAPf5nAfzqFc01nl7fFttICrFWX2EhMmn5pKnlBCRB
         ENo1MFhXxtbmjCL4qeXUrFDf7PnLRODGKMS+pWPA6JF2nIxJub304voTQ4M001jQ+R
         yMECaNYNq/qe5r1gFZXVHphJqlUezL/r0M2scafJ8uUC/aTDqZSN6kMdAhVEsVq9tL
         L78TENTVgappAxn8Ydh2AckopXcbn3B2W/Q17i/bOdMWjyJ7vlN3meb8Z9QydKmHYL
         eaqYPjb/FBbZA==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 4/12/2019 8:30 PM, Robin Murphy wrote:
> On 11/04/2019 10:40, Lorenzo Pieralisi wrote:
>> [+Robin]
>>
>> I would like Robin to have a look before merging this patch so
>> that we agree that's the expected approach.
>=20
> It's a bit crazy, but I guess it's not really any worse than the existing=
 implementation. As long the comments and commit message clearly document t=
hat this is just trickery to reserve a 32-bit DMA address (which AFAICS the=
y more or less do) I don't think I have a significant objection.
>=20
> One suggestion I would make is using dma_alloc_attrs() with DMA_ATTR_NO_K=
ERNEL_MAPPING, to make it clear that this is being set aside for 'special' =
device purposes and is not intended to be accessed as a regular buffer (plu=
s I believe this is non-coherent, so that should also skip the small overhe=
ad of creating a non-cacheable remap).
Thanks Robin for your inputs. I'll take care of changing API from dma_alloc=
_coherent()/dma_free_coherent() to dma_alloc_attrs()/dma_free_attrs() in V3=
 patch.

>=20
> Ultimately, it might make sense to have an API in the PCI core which can =
look at memblock/bridge windows/etc. to find a suitable non-overlapping add=
ress for this kind of root-complex-integrated doorbell without having to su=
bvert the page allocator, as it seems to be a fairly common setup in 'embed=
ded' IPs.
>=20
> Robin.
>=20
>>
>> Lorenzo
>>
>> On Tue, Mar 19, 2019 at 07:32:01PM +0530, Vidya Sagar wrote:
>>> Since the upstream MSI memory writes are generated by downstream device=
s,
>>> it is logically correct to have MSI target memory coming from the DMA p=
ool
>>> reserved for PCIe than from the general memory pool reserved for CPU
>>> access. This avoids PCIe DMA addresses coinciding with MSI target addre=
ss
>>> thereby raising unwanted MSI interrupts. This patch also enforces to li=
mit
>>> the MSI target address to 32-bits to make it work for PCIe endponits th=
at
>>> support only 32-bit MSI target address and those endpoints that support
>>> 64-bit MSI target address anyway work with 32-bit MSI target address.
>>>
>>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>>> Reviewed-by: Thierry Reding <treding@nvidia.com>
>>> Acked-by: Thierry Reding <treding@nvidia.com>
>>> ---
>>> v2:
>>> * changed 'phys' type to 'dma_addr_t' from 'u64'
>>> * added a comment on why DMA mask is set to 32-bit
>>> * replaced 'dma' with 'DMA'
>>>
>>> =C2=A0 drivers/pci/controller/pci-tegra.c | 35 ++++++++++++++++++++++++=
++---------
>>> =C2=A0 1 file changed, 26 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controlle=
r/pci-tegra.c
>>> index f4f53d092e00..f8173a5e352d 100644
>>> --- a/drivers/pci/controller/pci-tegra.c
>>> +++ b/drivers/pci/controller/pci-tegra.c
>>> @@ -231,9 +231,9 @@ struct tegra_msi {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct msi_controller chip;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DECLARE_BITMAP(used, INT_PCI_MSI_NR);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct irq_domain *domain;
>>> -=C2=A0=C2=A0=C2=A0 unsigned long pages;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct mutex lock;
>>> -=C2=A0=C2=A0=C2=A0 u64 phys;
>>> +=C2=A0=C2=A0=C2=A0 void *virt;
>>> +=C2=A0=C2=A0=C2=A0 dma_addr_t phys;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int irq;
>>> =C2=A0 };
>>> @@ -1536,7 +1536,7 @@ static int tegra_pcie_msi_setup(struct tegra_pcie=
 *pcie)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 err =3D platform_get_irq_byname(pdev, "m=
si");
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (err < 0) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_err(dev, "fa=
iled to get IRQ: %d\n", err);
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto err;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto free_irq_domain;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 msi->irq =3D err;
>>> @@ -1545,17 +1545,34 @@ static int tegra_pcie_msi_setup(struct tegra_pc=
ie *pcie)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 tegra_msi_irq_chip.name, pcie);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (err < 0) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_err(dev, "fa=
iled to request IRQ: %d\n", err);
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto err;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto free_irq_domain;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 /* Though the PCIe controller can address >32-bit a=
ddress space, to
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * facilitate endpoints that support only 32-b=
it MSI target address,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * the mask is set to 32-bit to make sure that=
 MSI target address is
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * always a 32-bit address
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> +=C2=A0=C2=A0=C2=A0 err =3D dma_set_coherent_mask(dev, DMA_BIT_MASK(32)=
);
>>> +=C2=A0=C2=A0=C2=A0 if (err < 0) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_err(dev, "failed to set=
 DMA coherent mask: %d\n", err);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto free_irq;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 msi->virt =3D dma_alloc_coherent(dev, PAGE_SIZE, &m=
si->phys, GFP_KERNEL);
>>> +=C2=A0=C2=A0=C2=A0 if (!msi->virt) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_err(dev, "failed to all=
ocate DMA memory for MSI\n");
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 err =3D -ENOMEM;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto free_irq;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> -=C2=A0=C2=A0=C2=A0 /* setup AFI/FPCI range */
>>> -=C2=A0=C2=A0=C2=A0 msi->pages =3D __get_free_pages(GFP_KERNEL, 0);
>>> -=C2=A0=C2=A0=C2=A0 msi->phys =3D virt_to_phys((void *)msi->pages);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 host->msi =3D &msi->chip;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>> -err:
>>> +free_irq:
>>> +=C2=A0=C2=A0=C2=A0 free_irq(msi->irq, pcie);
>>> +free_irq_domain:
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 irq_domain_remove(msi->domain);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return err;
>>> =C2=A0 }
>>> @@ -1592,7 +1609,7 @@ static void tegra_pcie_msi_teardown(struct tegra_=
pcie *pcie)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct tegra_msi *msi =3D &pcie->msi;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int i, irq;
>>> -=C2=A0=C2=A0=C2=A0 free_pages(msi->pages, 0);
>>> +=C2=A0=C2=A0=C2=A0 dma_free_coherent(pcie->dev, PAGE_SIZE, msi->virt, =
msi->phys);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (msi->irq > 0)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 free_irq(msi->ir=
q, pcie);
>>> --=20
>>> 2.7.4
>>>

