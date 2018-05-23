Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 23 May 2018 16:16:04 +0530
From: Vinod <vkoul@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] PCI: qcom: add runtime pm support to pcie_port
Message-ID: <20180523104604.GH20991@vkoul-mobl>
References: <20180518070736.3003-1-bjorn.andersson@linaro.org>
 <20180523061536.GE20991@vkoul-mobl>
 <89bc5fc1-d4a3-4121-208c-546c62138699@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <89bc5fc1-d4a3-4121-208c-546c62138699@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 23-05-18, 11:10, Srinivas Kandagatla wrote:
> 
> 
> On 23/05/18 07:15, Vinod wrote:
> > On 18-05-18, 00:07, Bjorn Andersson wrote:
> > 
> > > diff --git a/drivers/pci/dwc/pcie-qcom.c b/drivers/pci/dwc/pcie-qcom.c
> > > index 5897af7d3355..3f35098b71b1 100644
> > > --- a/drivers/pci/dwc/pcie-qcom.c
> > > +++ b/drivers/pci/dwc/pcie-qcom.c
> > > @@ -1088,6 +1088,8 @@ static int qcom_pcie_host_init(struct pcie_port *pp)
> > >   	struct qcom_pcie *pcie = to_qcom_pcie(pci);
> > >   	int ret;
> > > +	pm_runtime_get_sync(pci->dev);
> > > +
> > >   	qcom_ep_reset_assert(pcie);
> > >   	ret = pcie->ops->init(pcie);
> > > @@ -1124,6 +1126,7 @@ static int qcom_pcie_host_init(struct pcie_port *pp)
> > >   	phy_power_off(pcie->phy);
> > >   err_deinit:
> > >   	pcie->ops->deinit(pcie);
> > > +	pm_runtime_put_sync(pci->dev);
> > 
> > Wondering if there is a reason for sync put here?
> pm_runtime_get_sync() call paired with a pm_runtime_put() call will be
> appropriate here I guess as per
> https://www.kernel.org/doc/Documentation/power/runtime_pm.txt

Yeah for the get call sync() is mostly appropriate as you would want hardware to
be up after this. For put most of cases people don't need it to be bought down
synchronously unless you have something specific required which was my question
here. Looks like that is not the case :)

> I will respin this patch.

Sure..

-- 
~Vinod
