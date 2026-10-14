Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E287B51589C;
	Wed, 14 Oct 2026 14:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791988852; cv=none; b=p/mqhU6DCcBjrxv5iHnW34vqOoAaCYFgYuOQmHXTsDyUSB52oF7J3LVDMQqgjxYKHkM5ZxvQQvdqS9Uhv/JkR6HV91nYDxQnVSSEvAarBPhoWZLbAGBJC9dErbNyg933Wf+1Pgov7VSbIjGIS2fcXCIc8I83vXNdNiYOJ5bl6Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791988852; c=relaxed/simple;
	bh=b0twN2SIOpKMdB7PTsiPZsIPhoL+xHL1EsRTRcYBBtg=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=LhpVF11XTsmP+9VUAuEslVlhNCiFdEQ9ry9pdIhNLNwFL/ajl2jrCa8YKkrcBhf3u4/eNxVyOjrM2gvPB/7daAc0Hq1p1X6ITkZtLycicjFRFyJUaQzsIAWdXwmVeIMZyxzSjWYwd8TwkmFoD9FppTxu5PA1b8MSe0eA5+PQe+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C0021F000C5;
	Wed, 14 Oct 2026 14:40:44 +0000 (UTC)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 11/11] PCI: endpoint: test: Do not relocate fixed MSI-X
 tables
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Manikanta Maddireddy <mmaddireddy@nvidia.com>, 
 Koichiro Den <den@valinux.co.jp>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 Krzysztof Wilczynski <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
 Rob Herring <robh@kernel.org>, Thierry Reding <thierry.reding@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 Vidya Sagar <vidyas@nvidia.com>, 
 Marco Crivellari <marco.crivellari@suse.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <arPjAeYzVbe5_qo8@ryzen>
References: <20260923072237.1139013-1-mmaddireddy@nvidia.com>
 <20260923072237.1139013-12-mmaddireddy@nvidia.com>
 <arPjAeYzVbe5_qo8@ryzen>
Date: Wed, 14 Oct 2026 20:10:32 +0530
Message-Id: <179198883276.63727.4456977474157450415.b4-reply@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4947;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=b0twN2SIOpKMdB7PTsiPZsIPhoL+xHL1EsRTRcYBBtg=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBqz5RjAg8poMtbeaH0vJCMnLKb27Vmmd+O/4uL4
 xJ+oytygLWJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCas+UYwAKCRBVnxHm/pHO
 9V71B/49NAqThU39U/9AA9irEPsKkNuzOVZNn/nFlme5BsMIRI7/mEty0cXNxLj/xTgMqasa0bd
 BVFQH0EhlRn+fZZNvNQ2Avgco9dk7q/Gc1e2stqK0KrbFiDl3bmk9tHRoQePFdEX64hGOEQeTck
 ZQFbFsh7Z1ahRgPyo/bXnFwxNYrSy5rY76GchSwRwYLux/V/rLqrSoN2aXtJ1odkzkGXcq0W2YW
 lvDiKGGrpoFQl6cbbpSl7cFxg0smjPKfhMkOXo+bNnsdrjv8TqYrBPpU480g6E9IjaYjRPKJYr5
 aZ0eywwpYBYxwHUwsQhiUVvWSBlapzSD4DQe6twC8xPSQO94
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

On 2026-09-23 16:32 +0200, Niklas Cassel wrote:
> On Wed, Sep 23, 2026 at 12:52:37PM +0530, Manikanta Maddireddy wrote:
> > Some endpoint controllers expose MSI-X table/PBA storage at fixed,
> > hardware-owned BARs. Such BARs are described to endpoint functions as
> > BAR_RESERVED with PCI_EPC_BAR_RSVD_MSIX_TBL_RAM, so the function driver
> > must not reprogram the MSI-X Table/PBA capability to point into ordinary
> > function BAR memory.
> > 
> > pci_epf_test always allocates MSI-X storage after its test registers and
> > calls pci_epc_set_msix(). On controllers with fixed MSI-X storage, this
> > overwrites the controller-defined MSI-X layout. For example, the generic
> > DesignWare path derives the PBA offset from the number of vectors, which
> > can make the host program the wrong MSI-X storage and prevent MSI-X
> > delivery.
> > 
> > Detect fixed MSI-X table BARs and leave the controller-owned MSI-X
> > capability layout unchanged. Keep allocating and programming MSI-X
> > storage in the test BAR only for controllers that do not advertise fixed
> > MSI-X table storage.
> > 
> > Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> > ---
> >  drivers/pci/endpoint/functions/pci-epf-test.c | 27 +++++++++++++++++--
> >  1 file changed, 25 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> > index d4905aa8e4c0..82d4714e998c 100644
> > --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> > +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> > @@ -83,6 +83,7 @@ struct pci_epf_test {
> >  	struct config_group	group;
> >  	enum pci_barno		test_reg_bar;
> >  	size_t			msix_table_offset;
> > +	bool			msix_table_fixed;
> >  	struct delayed_work	cmd_handler;
> >  	struct dma_chan		*dma_chan_tx;
> >  	struct dma_chan		*dma_chan_rx;
> > @@ -98,6 +99,26 @@ struct pci_epf_test {
> >  	size_t			bar_size[PCI_STD_NUM_BARS];
> >  };
> >  
> > +static bool pci_epf_test_msix_table_fixed(const struct pci_epc_features *features)
> > +{
> > +	enum pci_barno bar;
> > +	int i;
> > +
> > +	for (bar = BAR_0; bar < PCI_STD_NUM_BARS; bar++) {
> > +		const struct pci_epc_bar_desc *desc = &features->bar[bar];
> > +
> > +		if (desc->type != BAR_RESERVED)
> > +			continue;
> > +
> > +		for (i = 0; i < desc->nr_rsvd_regions; i++) {
> > +			if (desc->rsvd_regions[i].type == PCI_EPC_BAR_RSVD_MSIX_TBL_RAM)
> > +				return true;
> > +		}
> > +	}
> > +
> > +	return false;
> > +}
> > +
> >  struct pci_epf_test_reg {
> >  	__le32 magic;
> >  	__le32 command;
> > @@ -1214,7 +1235,7 @@ static int pci_epf_test_epc_init(struct pci_epf *epf)
> >  		}
> >  	}
> >  
> > -	if (epc_features->msix_capable) {
> > +	if (epc_features->msix_capable && !epf_test->msix_table_fixed) {
> >  		ret = pci_epc_set_msix(epc, epf->func_no, epf->vfunc_no,
> >  				       epf->msix_interrupts,
> >  				       epf_test->test_reg_bar,
> > @@ -1282,7 +1303,9 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
> >  
> >  	test_reg_bar_size = ALIGN(sizeof(struct pci_epf_test_reg), 128);
> >  
> > -	if (epc_features->msix_capable) {
> > +	epf_test->msix_table_fixed = pci_epf_test_msix_table_fixed(epc_features);
> > +
> > +	if (epc_features->msix_capable && !epf_test->msix_table_fixed) {
> >  		msix_table_size = PCI_MSIX_ENTRY_SIZE * epf->msix_interrupts;
> >  		epf_test->msix_table_offset = test_reg_bar_size;
> >  		/* Align to QWORD or 8 Bytes */
> 
> Here you are only updating pci-epf-test. What about the other EPF drivers?
> 

How can we test those other EPF drivers if there is no hw setup available? TBH,
we don't need to add all functionalities to all EPF drivers. Adding them to
pci-epf-test driver is enough. If other EPF driver maintainers want to add the
missing features, then they can add them after testing on relevant hw setup.

> 
> Also, if you run then pci_endpoint kselftest, with the default 2048 MSI-X
> interrupts. Are really all 2048 MSI-X successful?
> 
> It seems that often the "hardware owned" MSI-X table is much smaller than
> that. See e.g. Koichiro's series which tries to use "hardware owned" MSI-X
> table, but if the "hardware owned" MSI-X table is too small to hold all
> 2048 MSI-X IRQs, then "hardware owned" MSI-X table would not be used:
> 
> https://lore.kernel.org/linux-pci/20260830151948.3547577-2-den@valinux.co.jp/
> 
> +	if (layout->table_size < table_size || layout->pba_size < pba_size)
> +		return -ENOSPC;
> 
> 
> 
> Apparently NTB EPF needs to read the MSI-X table from RAM:
> https://lore.kernel.org/linux-pci/pj5vpwwd5tr5tuvhdq3bcpefnq27r6ljvwoysguz2o4tglcqx5@l7zmb6wjnhla/
> 
> Which is why he also decided to let an EPF driver choose if it should
> use "hardware owned" MSI-X table or not.
> 

Yeah, makes sense. Otherwise, we will see kselftests failures.

- Mani

