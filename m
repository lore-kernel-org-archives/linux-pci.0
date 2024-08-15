Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8101A00DF
	for <linux-pci@vger.kernel.org>; Thu, 15 Aug 2024 14:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723731444; cv=none; b=GCPM07+CYXLcVgpzN6uvnahPaHnGHkb3VySEGLHoF1GeqCM6as5rQ8heykPxN1hR349nGN416nvzIR5XY9OlYARmIm34fFEC2WGfDzOtMSYRpK+FYow5ogErIM6yXfzGDHYtrZSlw1vJ/eQXmcCrzclGka94QZsjiDDrERHhoMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723731444; c=relaxed/simple;
	bh=5vIaSKPm/dyiOijZwrvcQ1Qak8u8NIygx4v3MkyNC0Y=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ncFcim/9Ny1BBTe7s+OoOj+1r2G4InBc4yoyT9IJRoqq8bu54YF/1Xciw7wWIw2+bnOFl8K51ZbSD+cTnmi10rsppD6iqXSFbKMxYMPH0o79d41agqbOA8Sq2TG9gtjdwtJ9J8OO7/ev4BA08XwrzGiEMiNMGcOlRsjjBrR3CCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Wl6Z63sGDz6K99p;
	Thu, 15 Aug 2024 22:14:22 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 258E3140A9C;
	Thu, 15 Aug 2024 22:17:19 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 15 Aug
 2024 15:17:18 +0100
Date: Thu, 15 Aug 2024 15:17:17 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Keith Busch <kbusch@meta.com>
CC: <linux-pci@vger.kernel.org>, <bhelgaas@google.com>, <lukas@wunner.de>,
	<mika.westerberg@linux.intel.com>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH RFC 1/8] pci: make pci_stop_dev concurrent safe
Message-ID: <20240815151717.00007e7c@Huawei.com>
In-Reply-To: <20240722151936.1452299-2-kbusch@meta.com>
References: <20240722151936.1452299-1-kbusch@meta.com>
	<20240722151936.1452299-2-kbusch@meta.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 22 Jul 2024 08:19:29 -0700
Keith Busch <kbusch@meta.com> wrote:

> From: Keith Busch <kbusch@kernel.org>
> 
> Use the atomic ADDED flag to safely ensure concurrent callers can't
> attempt to stop the device multiple times.

Maybe mention what concurrent paths exist where this might happen.

> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
Change looks sensible anyway. FWIW as I'm not an expert in these paths.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
