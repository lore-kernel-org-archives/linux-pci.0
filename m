Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21077286D57;
	Wed, 18 Feb 2026 12:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771417513; cv=none; b=TmRoZYjmE4W7AgvEBJS2sNP8iRDTlBrdplE/OLeWBMtX1/AVHAXxxA+Vgl9WkDNSTL+wrCuDDO1v6DcsYKETG1ygMB/eAaFExFhGQZIyfHsjWVeIY70jSYoZL3LeYPG7UqwLC0ObK0Rc0aFYc0d5nYF0tKnLRiF73YgLAiy+ir0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771417513; c=relaxed/simple;
	bh=t07p9ECT7bUMx/cyw0tO918mUa6oHHrLDEO+w+U6KxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ss1YKSwK4Y9DE85p8BE7NcBKzNpX3xU6ytDg8Px/ioNCZWalh1IgmwFxedpSL6TsmsQswQB6TeP4p9g6yZg8CIlV4sgGOrI8pSXBgZAakxmc4lRiXiwka71ABbx0xNHAg4DxATfCeN18SLG86RsmJ0dBb2PgFp2suzOGE8edz+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G8MKFjEo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G8MKFjEo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 586C4C19421;
	Wed, 18 Feb 2026 12:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771417512;
	bh=t07p9ECT7bUMx/cyw0tO918mUa6oHHrLDEO+w+U6KxQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G8MKFjEoCgVvti0AiGuIuWwxjNfB2zr6kx4FokOGUfbyo1S/3iz/l85y70MIHEyLY
	 aT0YXjqRc1j/y0CyL2YNpYKyACsJ7J6admDaGCj/EdD/DRShc+TFMVzPlBbVfqNur6
	 geRYT4RU3Ze7rsYd8uClJfafmOd3zal1C0O99W6wAJmpYFG0JyL783bHuWFdzbTtdT
	 qb3U046hN5Sl1opwcvhMtRjY51OY3Docg13dtisbz7b19TYkY8wriYTv6umfaj13o9
	 iuRxg88vEY5MrXSdHWlF5Q03gk+pDc00Vw8QdOYlAZfAsHSTcgwIPGyv1AysOszt/Q
	 WkE9TE3UlqwfA==
Date: Wed, 18 Feb 2026 17:54:58 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>
Cc: manivannan.sadhasivam@oss.qualcomm.com, 
	Bartosz Golaszewski <brgl@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Subject: Re: [PATCH 2/2] PCI/pwrctrl: Only create pwrctrl device if the
 device node is of type "pci"
Message-ID: <5qrvtbr2vnjp2qcopf3fgygto54lsma6bpz37hgjealbuso43u@ijolgjmtk2er>
References: <20260217-pwrctrl-fixes-7-0-v1-0-b5671e58934f@oss.qualcomm.com>
 <20260217-pwrctrl-fixes-7-0-v1-2-b5671e58934f@oss.qualcomm.com>
 <jmy7rvoatiyvqjfhd27vqqbu64glnksyl23j2akrdb7iet3oqx@c5jxbrplubd3>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <jmy7rvoatiyvqjfhd27vqqbu64glnksyl23j2akrdb7iet3oqx@c5jxbrplubd3>

On Tue, Feb 17, 2026 at 12:09:56PM -0600, Bjorn Andersson wrote:
> On Tue, Feb 17, 2026 at 03:48:47PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> > From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > 
> > The PCI host bridge node can have non-PCI child nodes as well, like OPP
> > tables, USB controller node etc...
> 
> Yes, but the usb-controller in my case is a PCI child and should be
> pwrctrl'ed. The entity that I don't want pcictrl to handle is the HUB
> child on the USB bus.
> 

I was wrong here. More below...

> > So the pwrctrl core must check for the
> > presence of 'device_type' property with value of "pci" to ensure that the
> > pwrctrl device is only created for PCI device nodes.
> > 
> > Fixes: 4c4132489201 ("PCI/pwrctrl: Add APIs to create, destroy pwrctrl devices")
> > Reported-by: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
> > Closes: https://lore.kernel.org/all/20260212-rb3gen2-upd-gl3590-v1-1-18fb04bb32b0@oss.qualcomm.com
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > ---
> >  drivers/pci/pwrctrl/core.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/pci/pwrctrl/core.c b/drivers/pci/pwrctrl/core.c
> > index 8325858cc379..7404d48427ce 100644
> > --- a/drivers/pci/pwrctrl/core.c
> > +++ b/drivers/pci/pwrctrl/core.c
> > @@ -272,8 +272,9 @@ EXPORT_SYMBOL_GPL(pci_pwrctrl_power_on_devices);
> >   * Check whether the pwrctrl device really needs to be created or not. The
> >   * pwrctrl device will only be created if the node satisfies below requirements:
> >   *
> > - * 1. Presence of compatible property to match against the pwrctrl driver (AND)
> > - * 2. At least one of the power supplies defined in the devicetree node of the
> > + * 1. Presence of 'device_type = "pci"' property to identify PCI node (AND)
> > + * 2. Presence of compatible property to match against the pwrctrl driver (AND)
> > + * 3. At least one of the power supplies defined in the devicetree node of the
> >   *    device (OR) in the remote endpoint parent node to indicate pwrctrl
> >   *    requirement.
> >   */
> > @@ -281,6 +282,9 @@ static bool pci_pwrctrl_is_required(struct device_node *np)
> >  {
> >  	struct device_node *endpoint;
> >  
> > +	if (!of_node_is_type(np, "pci"))
> > +		return false;
> 
> This "solves" my problem by no longer attempting to power on the
> onboard_hub. But it also ensures that Neil's added μPD720201 power
> controller doesn't power on.
> 
> This is based on the expectation that I shouldn't mark the PCI device
> (the μPD720201) as device_type = "pci", right? (Doing so makes dtc barf,
> but the μPD720201 is powered up, and functional).
> 

Ah, this property is applicable only to bridges, not endpoints. So dt checker
was right and I was wrong :(

> If this is incorrect, can you please help me understand how the
> usb-controller@0,0 node should look like in
> https://lore.kernel.org/all/20260212-rb3gen2-upd-gl3590-v1-1-18fb04bb32b0@oss.qualcomm.com/
> 

Will the below diff on top of this series help? It checks for the presence of
the 'pci' prefix in the device compatible, which should always exist for all
kind of PCI devices including the USB controller and will be absent for the
internal USB hub, which will have 'usb' prefix.

---
diff --git a/drivers/pci/pwrctrl/core.c b/drivers/pci/pwrctrl/core.c
index 7404d48427ce..7754baed67f2 100644
--- a/drivers/pci/pwrctrl/core.c
+++ b/drivers/pci/pwrctrl/core.c
@@ -272,20 +272,23 @@ EXPORT_SYMBOL_GPL(pci_pwrctrl_power_on_devices);
  * Check whether the pwrctrl device really needs to be created or not. The
  * pwrctrl device will only be created if the node satisfies below requirements:
  *
- * 1. Presence of 'device_type = "pci"' property to identify PCI node (AND)
- * 2. Presence of compatible property to match against the pwrctrl driver (AND)
- * 3. At least one of the power supplies defined in the devicetree node of the
+ * 1. Presence of compatible property with "pci" prefix to match against the
+ *    pwrctrl driver (AND)
+ * 2. At least one of the power supplies defined in the devicetree node of the
  *    device (OR) in the remote endpoint parent node to indicate pwrctrl
  *    requirement.
  */
 static bool pci_pwrctrl_is_required(struct device_node *np)
 {
        struct device_node *endpoint;
+       const char *compat;
+       int ret;
 
-       if (!of_node_is_type(np, "pci"))
+       ret = of_property_read_string(np, "compatible", &compat);
+       if (ret < 0)
                return false;
 
-       if (!of_property_present(np, "compatible"))
+       if (!strstarts(compat, "pci"))
                return false;
 
        if (of_pci_supply_present(np))

- Mani

-- 
மணிவண்ணன் சதாசிவம்
