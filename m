Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2747C25A2B4;
	Wed, 28 Jan 2026 16:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769618121; cv=none; b=G/o+DimRpjTuAtxHmA83DySWQA6txuAzwY1pVd88ZJ4ndni5F1uiIoDUsiH7o7cynsunYOciigaxWg/PpDS9Kl0OO16vKM+0RpTr5RypbmaBR53PBFsVbeYAxaRCw5P0MJUQUGjQVowzUvwyp4sFAtPBuzBWOWwa+472yRIywn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769618121; c=relaxed/simple;
	bh=U01bh091G9PLI+JuRdjQCRyOdlCQOW6XHF7fSgDDJgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iSwmbxJjzwivG2Nt8AERDOu8LTo0fWyl6oAqr17KjwqleBfMNOGr/GO+rDzobSq5HsKl8ZvpwY6DhgphUZmdAFEBNe7pzbB5/DRfWO65WGNLOlRCAUTZlqhyGEeuAvPaDiw+v3P68jpRo5hMsmXkBYZTtKkbOIxRlxpHBM0bTqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e1B+nrsG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e1B+nrsG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90CF6C4CEF1;
	Wed, 28 Jan 2026 16:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769618120;
	bh=U01bh091G9PLI+JuRdjQCRyOdlCQOW6XHF7fSgDDJgs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e1B+nrsG3vVlVJnHV+I3V0o5U9JnlE2GaTjQDUYAkYvIW8LyVmausieXdfIOcruaR
	 24XD5xNIYnFHarj2EWroU2BuKjGk8Fbzqi2QpNRX+9tn262gIbe1LanT+DmHfSg+BY
	 jBrsPow7QNK6K/NLaqeDQfVuhfimGKewsWNMZM4yLdIV4IvDK47tWXj1qiaURyUm+x
	 869On/fz5Sc3+YbGLlNRi0WjBxsfLcP+1cHriTDzXFwCdvYrereUFh8n3AMrpl2aQ8
	 ORHa3RrH+ZYWdFyUItsLant1FcOTMKY9jsy8WrVMPoD8VR10jJZ4uVyPprCwQBk64v
	 sl7E3Pc0Sp+Lw==
Date: Wed, 28 Jan 2026 17:35:15 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>, Frank.Li@nxp.com,
	dlemoal@kernel.org, Koichiro Den <den@valinux.co.jp>,
	linux-pci@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] PCI: endpoint: pci-epf-test: Allow overriding default
 BAR sizes
Message-ID: <aXo6w4AM-UgoyICd@ryzen>
References: <20260123180747.827357-2-cassel@kernel.org>
 <yowgralxd7i55p63wqc7jxffwz5iqtrlztndpqu5yqeavhtscn@ajwd6r27ra6a>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yowgralxd7i55p63wqc7jxffwz5iqtrlztndpqu5yqeavhtscn@ajwd6r27ra6a>

Hello Mani,

On Wed, Jan 28, 2026 at 01:47:45PM +0530, Manivannan Sadhasivam wrote:
> > +
> > +	# grep . functions/pci_epf_test/func1/pci_epf_test.0/bar?_size
> > +	  functions/pci_epf_test/func1/pci_epf_test.0/bar0_size:512
> > +	  functions/pci_epf_test/func1/pci_epf_test.0/bar1_size:512
> > +	  functions/pci_epf_test/func1/pci_epf_test.0/bar2_size:1024
> > +	  functions/pci_epf_test/func1/pci_epf_test.0/bar3_size:16384
> > +	  functions/pci_epf_test/func1/pci_epf_test.0/bar4_size:131072
> > +	  functions/pci_epf_test/func1/pci_epf_test.0/bar5_size:1048576
> > +
> > +The user can override a default value using e.g.::
> > +	# echo 1048576 > functions/pci_epf_test/func1/pci_epf_test.0/bar1_size
> > +
> > +Note: Some endpoint controllers might have fixed size BARs, or reserved BARs,
> > +for such controllers, the corresponding BAR size in configfs will be ignored.
> > +
> 
> Silently ignoring the BAR size would create confusion. We should error out with
> -EOPNOTSUPP if the BAR is a fixed size BAR.

My initial idea was indeed to return -EOPNOTSUPP if the BAR is a fixed size BAR.
The problem however is that the information if a BAR is FIXED or not is in
epf->epc->features. epf->epc is NULL until the EPF has been bound to an EPC via
configfs.


> 
> >  
> >  Binding pci-epf-test Device to EP Controller
> >  --------------------------------------------
> > diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> > index b785d488c284..fda257e46920 100644
> > --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> > +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> > @@ -63,6 +63,7 @@ static struct workqueue_struct *kpcitest_workqueue;
> >  struct pci_epf_test {
> >  	void			*reg[PCI_STD_NUM_BARS];
> >  	struct pci_epf		*epf;
> > +	struct config_group	group;
> >  	enum pci_barno		test_reg_bar;
> >  	size_t			msix_table_offset;
> >  	struct delayed_work	cmd_handler;
> > @@ -76,6 +77,7 @@ struct pci_epf_test {
> >  	bool			dma_private;
> >  	const struct pci_epc_features *epc_features;
> >  	struct pci_epf_bar	db_bar;
> > +	size_t			bar_size[PCI_STD_NUM_BARS];
> >  };
> >  
> >  struct pci_epf_test_reg {
> > @@ -102,7 +104,8 @@ static struct pci_epf_header test_header = {
> >  	.interrupt_pin	= PCI_INTERRUPT_INTA,
> >  };
> >  
> > -static size_t bar_size[] = { 512, 512, 1024, 16384, 131072, 1048576 };
> > +/* default BAR sizes, can be overridden by the user using configfs */
> > +static size_t default_bar_size[] = { 512, 512, 1024, 16384, 131072, 1048576 };
> >  
> >  static void pci_epf_test_dma_callback(void *param)
> >  {
> > @@ -1070,7 +1073,7 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
> >  		if (epc_features->bar[bar].type == BAR_FIXED)
> >  			test_reg_size = epc_features->bar[bar].fixed_size;
> >  		else
> > -			test_reg_size = bar_size[bar];
> > +			test_reg_size = epf_test->bar_size[bar];
> >  
> >  		base = pci_epf_alloc_space(epf, test_reg_size, bar,
> >  					   epc_features, PRIMARY_INTERFACE);
> > @@ -1142,6 +1145,87 @@ static void pci_epf_test_unbind(struct pci_epf *epf)
> >  	pci_epf_test_free_space(epf);
> >  }
> >  
> > +#define PCI_EPF_TEST_BAR_SIZE_R(_name, _id)				\
> > +	static ssize_t pci_epf_test_##_name##_show(struct config_item *item,	\
> > +						   char *page)		\
> > +	{								\
> > +		struct config_group *group = to_config_group(item);	\
> > +		struct pci_epf_test *epf_test = container_of(group,	\
> > +					struct pci_epf_test, group);	\
> > +									\
> > +		return sprintf(page, "%zu\n", epf_test->bar_size[_id]);	\
> > +	}
> > +
> > +#define PCI_EPF_TEST_BAR_SIZE_W(_name, _id)				\
> > +	static ssize_t pci_epf_test_##_name##_store(struct config_item *item, \
> > +						    const char *page, size_t len) \
> > +	{								\
> > +		struct config_group *group = to_config_group(item);	\
> > +		struct pci_epf_test *epf_test = container_of(group,	\
> > +					struct pci_epf_test, group);	\
> > +		int val;						\
> > +		int ret;						\
> > +									\
> > +		ret = kstrtouint(page, 0, &val);			\
> > +		if (ret)						\
> > +			return ret;					\
> > +									\
> > +		if (!is_power_of_2(val))				\
> > +			return -EINVAL;					\
> > +									\
> > +		epf_test->bar_size[_id] = val;				\
> > +									\
> > +		return len;						\
> > +	}
> > +
> > +PCI_EPF_TEST_BAR_SIZE_R(bar0_size, BAR_0)
> > +PCI_EPF_TEST_BAR_SIZE_W(bar0_size, BAR_0)
> > +PCI_EPF_TEST_BAR_SIZE_R(bar1_size, BAR_1)
> > +PCI_EPF_TEST_BAR_SIZE_W(bar1_size, BAR_1)
> > +PCI_EPF_TEST_BAR_SIZE_R(bar2_size, BAR_2)
> > +PCI_EPF_TEST_BAR_SIZE_W(bar2_size, BAR_2)
> > +PCI_EPF_TEST_BAR_SIZE_R(bar3_size, BAR_3)
> > +PCI_EPF_TEST_BAR_SIZE_W(bar3_size, BAR_3)
> > +PCI_EPF_TEST_BAR_SIZE_R(bar4_size, BAR_4)
> > +PCI_EPF_TEST_BAR_SIZE_W(bar4_size, BAR_4)
> > +PCI_EPF_TEST_BAR_SIZE_R(bar5_size, BAR_5)
> > +PCI_EPF_TEST_BAR_SIZE_W(bar5_size, BAR_5)
> > +
> > +CONFIGFS_ATTR(pci_epf_test_, bar0_size);
> > +CONFIGFS_ATTR(pci_epf_test_, bar1_size);
> > +CONFIGFS_ATTR(pci_epf_test_, bar2_size);
> > +CONFIGFS_ATTR(pci_epf_test_, bar3_size);
> > +CONFIGFS_ATTR(pci_epf_test_, bar4_size);
> > +CONFIGFS_ATTR(pci_epf_test_, bar5_size);
> > +
> > +static struct configfs_attribute *pci_epf_test_attrs[] = {
> > +	&pci_epf_test_attr_bar0_size,
> > +	&pci_epf_test_attr_bar1_size,
> > +	&pci_epf_test_attr_bar2_size,
> > +	&pci_epf_test_attr_bar3_size,
> > +	&pci_epf_test_attr_bar4_size,
> > +	&pci_epf_test_attr_bar5_size,
> > +	NULL,
> > +};
> > +
> > +static const struct config_item_type pci_epf_test_group_type = {
> > +	.ct_attrs	= pci_epf_test_attrs,
> > +	.ct_owner	= THIS_MODULE,
> > +};
> > +
> > +static struct config_group *pci_epf_test_add_cfs(struct pci_epf *epf,
> > +						 struct config_group *group)
> > +{
> > +	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
> > +	struct config_group *epf_group = &epf_test->group;
> > +	struct device *dev = &epf->dev;
> > +
> > +	config_group_init_type_name(epf_group, dev_name(dev),
> > +				    &pci_epf_test_group_type);
> > +
> > +	return epf_group;
> > +}
> > +
> >  static const struct pci_epf_device_id pci_epf_test_ids[] = {
> >  	{
> >  		.name = "pci_epf_test",
> > @@ -1154,6 +1238,7 @@ static int pci_epf_test_probe(struct pci_epf *epf,
> >  {
> >  	struct pci_epf_test *epf_test;
> >  	struct device *dev = &epf->dev;
> > +	enum pci_barno bar;
> >  
> >  	epf_test = devm_kzalloc(dev, sizeof(*epf_test), GFP_KERNEL);
> >  	if (!epf_test)
> > @@ -1161,6 +1246,8 @@ static int pci_epf_test_probe(struct pci_epf *epf,
> >  
> >  	epf->header = &test_header;
> >  	epf_test->epf = epf;
> > +	for (bar = BAR_0; bar < PCI_STD_NUM_BARS; bar++)
> > +		epf_test->bar_size[bar] = default_bar_size[bar];
> >  
> 
> It'd be more clean if 'epf_test->bar_size[bar]' always holds the actual BAR size
> i.e., one of default/user configured/fixed size. This will allow us to print the
> actual BAR size used for testing. For this, the initial size setting should
> happen in pci_epf_test_bind().

# mkdir functions/pci_epf_test/func1
will cause pci_epf_test_probe() to be called.

At this point, when the EPF has been created, but not bound to an EPC,
the user could still do:

# grep . functions/pci_epf_test/func1/pci_epf_test.0/bar?_size

If we want this to show something other than e.g. size 0 for all BAR
before binding to and EPC, then we thus need to initialize it in probe().

If you are happy with showing sizes as zero, and that the configfs writes
that a user made to bar*_size before binding to a EPC will be overwritten
(I guess we could also return -EINVAL if bar*_size is written before an EPC
has been bound to the EPF), the next problem is that:

# ln -s functions/pci_epf_test/func1 controllers/a40000000.pcie-ep/
[  578.073152] pci_epf_test_bind
[  578.075614] pci_epf_test_epc_init

will cause both pci_epf_test_bind and pci_epf_test_epc_init to be called.
(for all platforms expect those that can only work with external reference
clock).

As you know, pci_epf_test_epc_init() will call set_bar().

So, the suggestion in this patch is the most pragmatic way I could think of.


The only better solution would be to move all the set_bar() code (and probably
all code) from pci_epf_test_epc_init() to

# echo 1 > controllers/a40000000.pcie-ep/start

time.

But AFAICT, we do not have any callback in an EPF driver that gets called
before the link is started.

I guess we could theoretically add a new EPF callback which pci-epc-core.c
calls for each EPF driver, before calling epc->ops->start(epc); :

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 068155819c57..dc717c5fd195 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -180,6 +180,7 @@ EXPORT_SYMBOL_GPL(pci_epc_stop);
  */
 int pci_epc_start(struct pci_epc *epc)
 {
+       struct pci_epf *epf;
        int ret;
 
        if (IS_ERR(epc))
@@ -188,6 +189,14 @@ int pci_epc_start(struct pci_epc *epc)
        if (!epc->ops->start)
                return 0;
 
+       mutex_lock(&epc->list_lock);
+       list_for_each_entry(epf, &epc->pci_epf, list) {
+               mutex_lock(&epf->lock);
+               if (epf->event_ops && epf->event_ops->epc_start_link)
+                       epf->event_ops->epc_start_link(epf);
+               mutex_unlock(&epf->lock);
+       }
+
        mutex_lock(&epc->lock);
        ret = epc->ops->start(epc);
        mutex_unlock(&epc->lock);


I guess it should work.

But I am slightly worried of the complexity it brings...
Because we already have an .epc_init callback in an EPF driver.
If we also bring add a ".pre_start_link" callback in an EPF driver,
how should an EPF driver developer know what to put in each callback?

I guess in that case we would want to remove the .epc_init callback?

(Because calling .set_bar() etc. should work to be called in a
.pre_start_link for both those driver relying on external refclock and
for those that don't.

If you do
# echo 1 > controllers/a40000000.pcie-ep/start
on a platform that requires an external reflock, before the external
refclock is available, that is your own fault.

I guess we could detect that and give a nice error.)


Kind regards,
Niklas
