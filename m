Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378C03A784E;
	Mon,  9 Mar 2026 14:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773065600; cv=none; b=UMPMMhqFsjOft2hNaMWZOP6m7nP8uPm2cVb73IFMhL0QC4AWxGHo4kli0aB+xBMZZ/tfyj8WOKGZL/5acdTwS9HjQTkhKSZnk28ATbit6cb29CSvmWHPWvcMbM6gWKTiaDBengsktaaib6kmrYH9zaNC3kSeWwsOx1H9O0yaSPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773065600; c=relaxed/simple;
	bh=KDsC1bQJZ1VMk+Y6ZYTZNOy/8vHputm9lVKTGv4yS/I=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MLz2Cq0L61qLmvVnizScDBrpn5QQvQtkzsCvDKKtMc5r/NYqRoOy+ilG2gSmwR2PzdWHEeoHz7GyIO1cy2oOqryFFwmIjhzF6tKXu2dBcB9XLm2WCHut7rdeOdo0vRkhuo9p5pXJRLnlOQ4qZqvQxTGN6vUtzmgLBGv9pCqWkLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fTzWF2jY8zHnH45;
	Mon,  9 Mar 2026 22:13:13 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 3CDA840086;
	Mon,  9 Mar 2026 22:13:17 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 9 Mar
 2026 14:13:16 +0000
Date: Mon, 9 Mar 2026 14:13:15 +0000
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
Subject: Re: [PATCH v16 09/10] cxl: Remove Endpoint AER correctable handler
Message-ID: <20260309141315.00005b52@huawei.com>
In-Reply-To: <20260302203648.2886956-10-terry.bowman@amd.com>
References: <20260302203648.2886956-1-terry.bowman@amd.com>
	<20260302203648.2886956-10-terry.bowman@amd.com>
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

On Mon, 2 Mar 2026 14:36:47 -0600
Terry Bowman <terry.bowman@amd.com> wrote:

> CXL drivers dont require a correctable PCI AER handler. Correctable AER
> errors reported by CXL devices are logged and cleared in the AER driver.
> This makes the correctable AER handler callback in the CXL driver
> unnecessary.
> 
> Remove cxl_cor_error_detected() and drop the .cor_error_detected callback
> from the CXL PCI error handlers.
> 
> This consolidates correctable error reporting under the CXL RAS infrastructure
> and avoids redundant or conflicting logging with the AER driver.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Nice.
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
