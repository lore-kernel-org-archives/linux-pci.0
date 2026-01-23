Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCB8335559
	for <linux-pci@vger.kernel.org>; Fri, 23 Jan 2026 10:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769162852; cv=none; b=ZjyLZdxr91H6P/FzSPoFzd+ingyR8OusXP3XCr6RCmFEkVgATGX/bPuWHmf2JtQqmGU4HyDSLOJ/hnJ0v8pFX71gfZmuYPCBewiJDcJ6Mxf0yMwPkQRgG8otHQ9BH2bciwswW4iezBDV0wyTujnqDArjlFMJQ4fCcPU2Lsug3hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769162852; c=relaxed/simple;
	bh=9FgKZVgPz1eysPqvodM89xUsgQmQ3piy6y+2hY/pmoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rY3MQ/kCGKsDg01we0dl42s1QjuzL1ov01klpDP7DZWBJcMn5j0dlYFIXD2GsGpMiCvYXofq7isF1SOkOUDtLBo2YFDH/zKsQMQDb2Ba6s6y/e6Wdxq9iMA2uHhggttZt643hhhNbU856CxTtB51IsSCm3pQsxX1WUbQ3hzyO9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G9D3oJJ0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G9D3oJJ0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19DC0C4CEF1;
	Fri, 23 Jan 2026 10:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769162851;
	bh=9FgKZVgPz1eysPqvodM89xUsgQmQ3piy6y+2hY/pmoM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G9D3oJJ0izv4sVITPHnRxyzhAXcjkAuAtqYKZ35OQlQI0cdC28yOdL72Ox1y51N7h
	 6fM5QPMI5VMkVbQMAcbCt3IDV/+YxgjRyTYgQCPadrY8S7qrY/rmUFKtuATETjJzIp
	 c5mu9ztEvGBviI39MZ/AhlQ0ueAw4We22P7XzjTPcCeVYeWc/y92b9jFlzZuvOfYh7
	 omdcKY4NZ+qOUMMZ7mNU9mwUFAsqOkLY/vo5BpA4uLQbGQQSrHjcfivnYFsXwrmvFC
	 jZxFkoDebTK1iPuLNCYBHXu50q3STTzCOGsk18lF6l+oOGccIutRxSCKAb5cxm9/pf
	 rxWzwOLACwC7A==
Date: Fri, 23 Jan 2026 11:07:25 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Randolph Lin <randolph@andestech.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Frank Li <Frank.Li@nxp.com>, Charles Mirabile <cmirabil@redhat.com>,
	tim609@andestech.com, "Maciej W. Rozycki" <macro@orcam.me.uk>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 4/4] PCI: dwc: Fix missing iATU setup when ECAM is
 enabled
Message-ID: <aXNIXQH_jd4Guakj@ryzen>
References: <20260123093208.593506-6-cassel@kernel.org>
 <20260123093208.593506-10-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123093208.593506-10-cassel@kernel.org>

On Fri, Jan 23, 2026 at 10:32:13AM +0100, Niklas Cassel wrote:
> From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> 
> When ECAM is enabled, the driver skipped calling dw_pcie_iatu_setup()
> before configuring ECAM iATU entries. This left IO and MEM outbound
> windows unprogrammed, resulting in broken IO transactions. Additionally,
> dw_pcie_config_ecam_iatu() was only called during host initialization,
> so ECAM-related iATU entries were not restored after suspend/resume,
> leading to failures in configuration space access
> 
> To resolve these issues, the ECAM iATU configuration is moved into
> dw_pcie_iatu_setup(), and dw_pcie_iatu_setup() is invoked when ECAM is
> enabled.
> 
> Furthermore, error checks are added in dw_pcie_prog_outbound_atu() and
> dw_pcie_prog_inbound_atu() such that an error is returned if trying to
> program an iATU that is outside the number of iATUs provided by the
> controller.
> 
> Fixes: f6fd357f7afb ("PCI: dwc: Prepare the driver for enabling ECAM mechanism using iATU 'CFG Shift Feature'")
> Reported-by: Maciej W. Rozycki <macro@orcam.me.uk>
> Closes: https://lore.kernel.org/all/alpine.DEB.2.21.2511280256260.36486@angie.orcam.me.uk/
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> Co-developed-by: Niklas Cassel <cassel@kernel.org>
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---

Unfortunately there is another difference when running the DWC driver in
ECAM mode.

pp->cfg0_io_shared (which toggles iATU index 0 between CFG and I/O space
can not be used when using ECAM, since they don't have this code that
overwrites/restores the iATU configuration, see dw_pcie_rd_other_conf()
and dw_pcie_wr_other_conf().

ECAM instead uses:
pci_generic_config_read() and pci_generic_config_write()

So we would need this squashed into this patch:

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index e65ffba6529b..bc2e08ec515e 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -990,8 +990,14 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
 			 * be shared between I/O space and CFG IOs, by
 			 * temporarily reconfiguring the iATU to CFG space, in
 			 * order to do a CFG IO, and then immediately restoring
-			 * it to I/O space.
+			 * it to I/O space. This is only implemented when using
+			 * dw_pcie_other_conf_map_bus(), which is not the case
+			 * when using ECAM.
 			 */
+			if (pp->ecam_enabled) {
+				dev_err(pci->dev, "Cannot add outbound window for I/O\n");
+				return -ENOMEM;
+			}
 			pp->cfg0_io_shared = true;
 		}
 	}


If we get no further comments, perhaps Mani could squash this?


Kind regards,
Niklas
