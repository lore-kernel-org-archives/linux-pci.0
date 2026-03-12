Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7891F3C455D;
	Thu, 12 Mar 2026 13:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773320708; cv=none; b=daHUSaCwJtLtevbxi6zqHoXqWf2/PW6qegXC6OAb9lKiq9S7XLZRQmbYIT6kDs+SoXTTGalu7ScXNJdOVejNEj4jSCb4C7KdOx3pM7geQVXf0TQwG7jZw9cVABCDnQZenKKdG0J3v6GCLgypPuTDqtQHcqqz6y3rXdCZwgIPXj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773320708; c=relaxed/simple;
	bh=6Ei2vJ1bnUym9lAVWazKzaZlFn1Ck2FO0adivCJpr/s=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pmZJyxnc1TsF5hYZA1Dh9YmBu+Vwn41VAW5RbwmVQYfO+pmExQGGkVg8HPnLPOPnOzOm9M+KMufGROORXjtN9X2OkgmU2KIvJxX/9ADxv6qApZwvf+6FC5fokoMcy9tsLY/ukXa7Tac54PRJpl0/ogzZHqlqNN7n2Pbcbly/UgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fWns333l8zHnGh0;
	Thu, 12 Mar 2026 21:04:55 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 1E6D240587;
	Thu, 12 Mar 2026 21:05:05 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 12 Mar
 2026 13:05:04 +0000
Date: Thu, 12 Mar 2026 13:05:02 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: "Bowman, Terry" <terry.bowman@amd.com>
CC: <dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <shiju.jose@huawei.com>,
	<ming.li@zohomail.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<rrichter@amd.com>, <dan.carpenter@linaro.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <lukas@wunner.de>,
	<Benjamin.Cheatham@amd.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<linux-cxl@vger.kernel.org>, <vishal.l.verma@intel.com>, <alucerop@amd.com>,
	<ira.weiny@intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
Subject: Re: [PATCH v16 07/10] cxl: Update error handlers to support CXL
 Port devices
Message-ID: <20260312130502.00003404@huawei.com>
In-Reply-To: <d225ba1f-c574-45dc-ab9b-18c3bf45f217@amd.com>
References: <20260302203648.2886956-1-terry.bowman@amd.com>
	<20260302203648.2886956-8-terry.bowman@amd.com>
	<20260309140518.000009e2@huawei.com>
	<d225ba1f-c574-45dc-ab9b-18c3bf45f217@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Wed, 11 Mar 2026 10:37:33 -0500
"Bowman, Terry" <terry.bowman@amd.com> wrote:

> On 3/9/2026 9:05 AM, Jonathan Cameron wrote:
> > On Mon, 2 Mar 2026 14:36:45 -0600
> > Terry Bowman <terry.bowman@amd.com> wrote:
> >   
> >> CXL Protocol trace logging is called for Endpoints in cxl_handle_ras() and
> >> cxl_handle_cor_ras(). Trace logging support for CXL Port devices is missing.
> >>
> >> CXL Endpoint trace logging utilizes a separate trace routine than CXL Port
> >> device handling. Using is_cxl_memdev(), determine if the device is a CXL EP
> >> or one of the CXL Port devices.
> >>
> >> Update cxl_handle_ras() and cxl_handle_cor_ras() to call the CXL Port trace
> >> logging function. Change cxl_handle_ras() return values to be pci_ers_result_t
> >> type.  
> > 
> > Why this last bit?
> >   
> 
> You requested in previous review this should return a value more meaningful than bool.
> I changed to return pci_ers_result_t.
> 
> https://lore.kernel.org/linux-cxl/20260205171346.00001e6b@huawei.com/
Ah. I was probably thinking errnos.

Maybe not appropriate.  Given how it is used, a bool was probably the right answer.
Sorry!

J
> 
> 
> >>
> >> Check for invalid ras_base and add log messages if NULL.
> >>
> >> Signed-off-by: Terry Bowman <terry.bowman@amd.com>  
