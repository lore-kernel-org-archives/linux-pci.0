Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911B23921EA;
	Tue, 17 Mar 2026 21:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773782451; cv=none; b=SXZMIwmBi8GidBsz9UlfOa+VWMhknq6vk/hKAJWN+D7La4zHyOTPFm+0syjxaSw1Ns1j3Im/sGgSE0QJ2AJ8lmspcOYPbMuE6ReRILULkT27HsczjyyPZigeNy0h/UtELHyJ0kBl5y8gcToQxY9gO6eHtJZxV/kHz4BsQ2bDii4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773782451; c=relaxed/simple;
	bh=oFrY9te7uqPD8r7EoBSwCYXSO4S7zmyO1OhSMocepjU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=tCTsm69130gLDxvRyA+JkYLa1on1CRkpTVKvkv8Z+hFuAWMDpqk2TpaJN6VtB1xoQ4GoCowGKYmbffZjcwID42N2dDbUJ5mrrk7L3n4AVnkBjNvjiHNif40t4gEBBfuCsX+++xPnPr0KrfGoivVTIEFTB4mmeX2kLH5AtPAlbs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q5odKayz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q5odKayz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C51F5C4CEF7;
	Tue, 17 Mar 2026 21:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773782451;
	bh=oFrY9te7uqPD8r7EoBSwCYXSO4S7zmyO1OhSMocepjU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=q5odKayzjo5syOlp9BN34RbHpBgiFjSAmPmi7ffpUCMXDlxP2tw/egyM+KoebDMuP
	 zQa1x/HY+VyZ5qo5ahCQB6rsLfOWNPEuQrQu5njxWVZPf/4JNE56ObG427+K72Bb4D
	 HOwIbNaO6n1wfMTX/RqQXQZr8/5Outs8FB+6e6dvOTVCTkzoMbE2l6BRQpJUBHvHoz
	 U0rJDSKdcEwnBW2RWJyTi2K8YvLXeD44RT5XXUrf9t0e+Eq/qXLBQ/Ocuxato+CRkd
	 ka2ZEvdOgckG/8HxFwcA/h8nm7egRakuJyIxc/Gbh7+IiYCHpI3DtbxKNRwlg8SpTz
	 q01W7SmxZ83AA==
Date: Tue, 17 Mar 2026 16:20:49 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Tyrel Datwyler <tyreld@linux.ibm.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: Re: [PATCH v2 3/4] PCI: pnv_php: Simplify with scoped for each OF
 child loop
Message-ID: <20260317212049.GA108913@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260317133322.266102-7-krzysztof.kozlowski@oss.qualcomm.com>

On Tue, Mar 17, 2026 at 02:33:25PM +0100, Krzysztof Kozlowski wrote:
> Use scoped for-each loop when iterating over device nodes to make code a
> bit simpler.
> 
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Applied patches 3 and 4 to pci/hotplug for v7.1, thanks!

Mani will take care of patches 1 and 2.

> ---
> 
> Changes in v2:
> Tags
> ---
>  drivers/pci/hotplug/pnv_php.c | 19 +++++++------------
>  1 file changed, 7 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/pnv_php.c b/drivers/pci/hotplug/pnv_php.c
> index 5c020831e318..ff92a5c301b8 100644
> --- a/drivers/pci/hotplug/pnv_php.c
> +++ b/drivers/pci/hotplug/pnv_php.c
> @@ -215,24 +215,19 @@ static void pnv_php_reverse_nodes(struct device_node *parent)
>  static int pnv_php_populate_changeset(struct of_changeset *ocs,
>  				      struct device_node *dn)
>  {
> -	struct device_node *child;
> -	int ret = 0;
> +	int ret;
>  
> -	for_each_child_of_node(dn, child) {
> +	for_each_child_of_node_scoped(dn, child) {
>  		ret = of_changeset_attach_node(ocs, child);
> -		if (ret) {
> -			of_node_put(child);
> -			break;
> -		}
> +		if (ret)
> +			return ret;
>  
>  		ret = pnv_php_populate_changeset(ocs, child);
> -		if (ret) {
> -			of_node_put(child);
> -			break;
> -		}
> +		if (ret)
> +			return ret;
>  	}
>  
> -	return ret;
> +	return 0;
>  }
>  
>  static void *pnv_php_add_one_pdn(struct device_node *dn, void *data)
> -- 
> 2.51.0
> 
