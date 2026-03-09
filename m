Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC8435DCE3;
	Mon,  9 Mar 2026 14:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773065542; cv=none; b=p+r/z+cyZSFa1kcBptblgbLeWLzTT6lsB7lZgzSNi0FSAfwrU6ZqO1Y0FhKurwSjdCUD/4HbKNIqANfIkwy/GroAJvteWvzHKDK0n62UJFXvUKIk2EtNMHw2t9m74jRWL5gxiYwH3jjJl8TkHLDxP1vECww/t21T289vFAswUBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773065542; c=relaxed/simple;
	bh=SKeU4nEFLweoI1FCHofuok2YFfGmEz3kctP1OyIO480=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qk8/6TtViclDPWfaVijCBPQvEp92aqgw1SqhUImJjPlao4vZYGAGFEbHVfcn5U3Ee6pr/tFa18GCabp0/7K45U6ndxCy6NU7hzFGjGvtzg4aWvnpyFM4DcBhsPdh+rb8LWSUD1v1Ofix5rKj7RKM4uUREBrN1edQDfCpnNCWMVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fTzV61mqWzHnH5Q;
	Mon,  9 Mar 2026 22:12:14 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 1B7D440585;
	Mon,  9 Mar 2026 22:12:18 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 9 Mar
 2026 14:12:17 +0000
Date: Mon, 9 Mar 2026 14:12:15 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Terry Bowman <terry.bowman@amd.com>
CC: <dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <shiju.jose@huawei.com>,
	<ming.li@zohomail.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<rrichter@amd.com>, <dan.carpenter@linaro.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <lukas@wunner.de>,
	<Benjamin.Cheatham@amd.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<linux-cxl@vger.kernel.org>, <vishal.l.verma@intel.com>, <alucerop@amd.com>,
	<ira.weiny@intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
Subject: Re: [PATCH v16 08/10] cxl: Update Endpoint AER uncorrectable
 handler
Message-ID: <20260309141215.00006968@huawei.com>
In-Reply-To: <20260302203648.2886956-9-terry.bowman@amd.com>
References: <20260302203648.2886956-1-terry.bowman@amd.com>
	<20260302203648.2886956-9-terry.bowman@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Mon, 2 Mar 2026 14:36:46 -0600
Terry Bowman <terry.bowman@amd.com> wrote:

> CXL drivers now implement protocol RAS support. PCI protocol errors,
> however, continue to be reported via the AER capability and must still be
> handled by a PCI error recovery callback.
> 
> Replace the existing cxl_error_detected() callback in cxl/pci.c with a
> new cxl_pci_error_detected() implementation that handles uncorrectable
> AER PCI protocol errors. Changes for PCI Correctable protocol errors will
> be added in a future patch.
> 
> Introduce function cxl_uncor_aer_present() to handle and log the CXL
> Endpoint's AER errors. Endpoint fatal AER errors are not currently logged by
> the AER driver and require logging here with a call to pci_print_aer().
> 
> This cleanly separates CXL protocol error handling from PCI AER handling
> and ensures that each subsystem processes only the errors it is
> responsible.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Assisted-by: Azure:gpt4.1-nano-key
One question inline.

> 
> ---
> 
> Changes in v15->v16:
> - Update commit message (DaveJ)
> - s/cxl_handle_aer()/cxl_uncor_aer_present()/g (Jonathan)
> - cxl_uncor_aer_present(): Leave original result calculation based on
>   if a UCE is present and the provided state (Terry)
> - Add call to pci_print_aer(). AER fails to log because is upstream
>   link (Terry)
> 
> Changes in v14->v15:
> - Update commit message and title. Added Bjorn's ack.
> - Move CE and UCE handling logic here
> 
> Changes in v13->v14:
> - Add Dave Jiang's review-by
> - Update commit message & headline (Bjorn)
> - Refactor cxl_port_error_detected()/cxl_port_cor_error_detected() to
>   one line (Jonathan)
> - Remove cxl_walk_port() (Dan)
> - Remove cxl_pci_drv_bound(). Check for 'is_cxl' parent port is
>   sufficient (Dan)
> - Remove device_lock_if()
> - Combined CE and UCE here (Terry)
> 
> Changes in v12->v13:
> - Move get_pci_cxl_host_dev() and cxl_handle_proto_error() to Dequeue
>   patch (Terry)
> - Remove EP case in cxl_get_ras_base(), not used. (Terry)
> - Remove check for dport->dport_dev (Dave)
> - Remove whitespace (Terry)
> 
> Changes in v11->v12:
> - Add call to cxl_pci_drv_bound() in cxl_handle_proto_error() and
>   pci_to_cxl_dev()
> - Change cxl_error_detected() -> cxl_cor_error_detected()
> - Remove NULL variable assignments
> - Replace bus_find_device() with find_cxl_port_by_uport() for upstream
>   port searches.
> 
> Changes in v10->v11:
> - None
> ---
>  drivers/cxl/core/ras.c | 57 ++++++++++++++++++++++++------------------
>  drivers/cxl/cxlpci.h   |  9 +++----
>  drivers/cxl/pci.c      |  6 ++---
>  3 files changed, 39 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> index 254144d19764..884e40c66638 100644
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c
...


> +pci_ers_result_t cxl_pci_error_detected(struct pci_dev *pdev,
> +					pci_channel_state_t state)
> +{
> +	bool ue = cxl_uncor_aer_present(pdev);
> +	struct cxl_port *port = get_cxl_port(pdev);

This got a reference that wasn't (I think) previously taken.
I'm not spotting where that is released.  It it is somewhere beyond
this function, good to add a comment saying where.


> +	struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport_dev);
> +	struct device *dev = &cxlmd->dev;
> +
>  	switch (state) {
>  	case pci_channel_io_normal:
>  		if (ue) {
> @@ -441,7 +448,7 @@ pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>  	}
>  	return PCI_ERS_RESULT_NEED_RESET;
>  }
> -EXPORT_SYMBOL_NS_GPL(cxl_error_detected, "CXL");
> +EXPORT_SYMBOL_NS_GPL(cxl_pci_error_detected, "CXL");

