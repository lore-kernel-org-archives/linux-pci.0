Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6EAD3A9014;
	Wed, 21 Jan 2026 10:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768992345; cv=none; b=XA8rtSK1NfVx7xqvgWgFPe7NsLw5x7DJQOoDB6n/Zr5CZptoSWcgUVPOqjqjTXdS9BHdJOskvQx0ptMxpyrTGcz0gVqTcuqFnSYn5m6oTCNNC7gdnINJ0SSYaKfX9KTSfCEqLhsCb4zuWJ4gQHRyxHTGADEqqawAXIJG5ir9r0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768992345; c=relaxed/simple;
	bh=iM7PuQd9Px4A/EXEmHB6Gzpin26NFrQ+ywORknKb/Tw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VaM4PQHh75WFiragjUIMw18TftOiyv8/SVJww1MxzUUmszFuPHto0h8yJET59iW7TIIT5sDdT4nJR5ri+gBmtb4FmgFiH8QlXAmklY/72diaS9z8l7DD+iQ78ZRo+8X6yjhYzQNIbFU6rn9xO7vlIPS76QdW2ad3FqioFAn6AX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dx16n4Qv7zHnH4p;
	Wed, 21 Jan 2026 18:45:05 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 2F41C4056C;
	Wed, 21 Jan 2026 18:45:39 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 21 Jan
 2026 10:45:38 +0000
Date: Wed, 21 Jan 2026 10:45:36 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <smadhavan@nvidia.com>, <dave@stgolabs.net>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <ming.li@zohomail.com>,
	<rrichter@amd.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<huaisheng.ye@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <vaslot@nvidia.com>, <vsethi@nvidia.com>,
	<sdonthineni@nvidia.com>, <vidyas@nvidia.com>, <mochs@nvidia.com>,
	<jsequeira@nvidia.com>
Subject: Re: [PATCH v4 03/10] cxl: add type 2 helper and reset DVSEC bits
Message-ID: <20260121104536.00003c47@huawei.com>
In-Reply-To: <aa8d4f6a-e7bd-4a20-8d34-4376ea314b8f@intel.com>
References: <20260120222610.2227109-1-smadhavan@nvidia.com>
	<20260120222610.2227109-4-smadhavan@nvidia.com>
	<aa8d4f6a-e7bd-4a20-8d34-4376ea314b8f@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Tue, 20 Jan 2026 16:27:33 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> On 1/20/26 3:26 PM, smadhavan@nvidia.com wrote:
> > From: Srirangan Madhavan <smadhavan@nvidia.com>
> > 
> > Introduce a helper to identify CXL Type 2 devices and define the DVSEC
> > reset/cache control bits used by the reset flow.  
> 
> Should probably be 2 separate patches for these 2 things.

Also, follow existing convention and put them new DVSEC defs
in the uapi/pci_regs.h file.  The rest are moving there shortly.

Given they are now in a uapi file, I also wonder if we should just
fill in the rest of the structure definitions as a stand alone
patch.  A partial set isn't much use to userspace tooling.

Jonathan

> 
> > 
> > Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> > ---
> >  drivers/cxl/pci.c | 10 ++++++++++
> >  include/cxl/pci.h | 14 ++++++++++++++
> >  2 files changed, 24 insertions(+)
> > 
> > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > index 55c767df4543..b562e607ec46 100644
> > --- a/drivers/cxl/pci.c
> > +++ b/drivers/cxl/pci.c
> > @@ -1075,6 +1075,16 @@ static pci_ers_result_t cxl_slot_reset(struct pci_dev *pdev)
> >  	return PCI_ERS_RESULT_RECOVERED;
> >  }
> > 
> > +bool cxl_is_type2_device(struct pci_dev *pdev)
> > +{
> > +	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
> > +
> > +	if (!cxlds)
> > +		return false;
> > +
> > +	return cxlds->type == CXL_DEVTYPE_DEVMEM;
> > +}
> > +
> >  static void cxl_error_resume(struct pci_dev *pdev)
> >  {
> >  	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
> > diff --git a/include/cxl/pci.h b/include/cxl/pci.h
> > index 728ba0cdd289..71d8de5de948 100644
> > --- a/include/cxl/pci.h
> > +++ b/include/cxl/pci.h
> > @@ -14,10 +14,24 @@
> >  /* CXL 2.0 8.1.3: PCIe DVSEC for CXL Device */
> >  #define CXL_DVSEC_PCIE_DEVICE					0
> >  #define   CXL_DVSEC_CAP_OFFSET		0xA
> > +#define     CXL_DVSEC_CACHE_CAPABLE	BIT(0)
> >  #define     CXL_DVSEC_MEM_CAPABLE	BIT(2)
> >  #define     CXL_DVSEC_HDM_COUNT_MASK	GENMASK(5, 4)
> > +#define     CXL_DVSEC_CACHE_WBI_CAPABLE	BIT(6)
> > +#define     CXL_DVSEC_CXL_RST_CAPABLE	BIT(7)
> > +#define     CXL_DVSEC_CXL_RST_TIMEOUT_MASK	GENMASK(10, 8)
> > +#define     CXL_DVSEC_CXL_RST_MEM_CLR_CAPABLE	BIT(11)
> >  #define   CXL_DVSEC_CTRL_OFFSET		0xC
> >  #define     CXL_DVSEC_MEM_ENABLE	BIT(2)
> > +#define   CXL_DVSEC_CTRL2_OFFSET	0x10
> > +#define     CXL_DVSEC_DISABLE_CACHING	BIT(0)
> > +#define     CXL_DVSEC_INIT_CACHE_WBI	BIT(1)
> > +#define     CXL_DVSEC_INIT_CXL_RESET	BIT(2)
> > +#define     CXL_DVSEC_CXL_RST_MEM_CLR_ENABLE	BIT(3)
> > +#define   CXL_DVSEC_STATUS2_OFFSET	0x12
> > +#define     CXL_DVSEC_CACHE_INVALID	BIT(0)
> > +#define     CXL_DVSEC_CXL_RST_COMPLETE	BIT(1)
> > +#define     CXL_DVSEC_CXL_RESET_ERR	BIT(2)
> >  #define   CXL_DVSEC_RANGE_SIZE_HIGH(i)	(0x18 + ((i) * 0x10))
> >  #define   CXL_DVSEC_RANGE_SIZE_LOW(i)	(0x1C + ((i) * 0x10))
> >  #define     CXL_DVSEC_MEM_INFO_VALID	BIT(0)  
> 
> Should this chunk go with a different patch where the definitions are being used?
> 
> > --
> > 2.34.1
> >   
> 
> 

