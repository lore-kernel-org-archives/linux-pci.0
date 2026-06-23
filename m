Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4399F32B13A;
	Tue, 23 Jun 2026 23:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782255628; cv=none; b=Kg8QHwdAPgJ0aYc2xAZ1mT87VW3ZAk3NzVMIvdoLX6/wng7YPLPNBy+MTq5i351j5+6AqfA2RAJALfEzUXarHegiRH6/0eC6hHBGTctqLJ/b1dNH4eXEspqIr1BfgSUYqs62UZC+2s5qC6BAHMFAxb/YwConByXAZt/Nsvvf4aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782255628; c=relaxed/simple;
	bh=EdiiKLjRD46vSb2CJ7dKQ9NTwgPB8vCd50Ii9AJM4dg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=iMQgBZOkVXVNiz6oy0AHZ/9zzbVQ8YfXL7cKCGM3z/Rx8z732OHuKosMUpSr5a7FXbvsE1L0U0l7cm/cPlMAEUoRm8U8Xrq/rmWM6UcmE3plPyqAwyFk+/MIZMY7Ep1iTaETKmb/bA4+UaFC8V0FIgij3hr3zIIAcqTMQEnXv3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MABGRBkj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MABGRBkj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EC9F1F000E9;
	Tue, 23 Jun 2026 23:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782255626;
	bh=+ZprVd6hak79tT1yNBe6rbOrxYAvSnGiBcN53A2Yz+o=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=MABGRBkjQS5itEmQ7r1TXaG/omXwaKlhwOSkTKkhvJ09MFRRlB8eJtTMyQZcPywbh
	 GXcE3Ujf2q0pAfyeEaojtfJxHJdq0fL9Isue0Wp05VSy+gSJ9hWr2uOgICUkkmVOrH
	 8h4x8DEesjW8g62z+Vx1TSnbbpqueFyxJl5q3hsWABrU4I+qRFfInZ5eWD7ga08RLl
	 DPz26w0Rh5T/Nzql/RwEfoXAefnFsNng0h3Tx+CHq7is6L4JxLC+Eyqw3B/SOlDCCI
	 GdeIAIVrUsgN6uTw8FQ2kNFR1XG7iyP90Z+8+G+x9n7h8lrf6nOjvICi96AhHimIv5
	 N19pnroGDP/Xg==
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id 9D18CF40080;
	Tue, 23 Jun 2026 19:00:25 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 23 Jun 2026 19:00:25 -0400
X-ME-Sender: <xms:CRA7aiLzDt9yCcUiSmPF28u6Bgt1AEQ1jQtIUCdW7QqIxQbR5dnMUQ>
    <xme:CRA7aqnYkiKv6-4NWsm6N7Fe9s56eM-8xvDmTaLkOJLpRHl4_-1ShlbhHEef-WOt1
    cRIYHzeNCj-sZyLWSWc64PFVBtYz5cpNQ61VB0uXDlEuqwLbgFfQA>
X-ME-Received: <xmr:CRA7aoJZuMXS8XwRsrDbXNT0tp__BkKVHyvLWVOwCF4-IKdkKtEY-EZi7asZtOL0jsfWjJELlJCCXsLZpISuJFFmlS7QRpH6WIw>
X-ME-Proxy-Cause: dmFkZTEIzL0uJ2LqqIa9N1YVNmTbmTEQuSKhoCo5srAWzdz2Qh9Lv6qqFerEtRxPjFj13d
    xuSy+S+66BBCv3PUtYIhVMHXFcJlpk8zxz5K+MyiQw5KstOV8mFHj8zGspb/jrv2YI+kbi
    mbzShUzqzqZXw0WVQwqDoG/qG/vtXqLn1WJyvJA+qSeJlP+vKiN1MBsK3MIFDu6X58eehk
    kj2ekIRtSDmYe6z/aaaZO+JoCX/AZZ3JYWGOHX8IQAgF533MqwOpoHo0r4x/nUI32py8Sk
    z9pJlc8AwNQJ5aRTg0mSgnVQym4fdDiDFCW9IDGcWuFlD5caNCEKjRclC6WnpldfMQvfNn
    fU2ogdtr6wR5YnOtsMu6xzP+iQYYmx/TIqjtDFD0z4XLihZsjlvdNko6XVtoWZt91e7hbO
    dL6BNpzTTp98Xovcb3Iz6SzhbqGD/ug9Kcp5ulMnU9hbpSs3XqNQj+R67bXG6gBtHrZGyO
    Ui7DkuPb4pOx2kJtq8xEnVv13cK/oA2kDEwtgZg3VGYUbAu6oaXa9mpez3Yf8KJ1xx/81U
    mGOb535fD/w1lmDjzuwGypEKeiHTRSrs2JYLs8wt8juFdTsWZehE2V5iaYoXjsBcoUuwlH
    AiBVStdUpXXImkOnrj/hC8T2cFqqJbQ3dkXRibVCYj6fnCoupJ8EJSoMER8Q
X-ME-Proxy: <xmx:CRA7alU_-SWSGNiDP6xp82F28XG6yOjv6FX6tK2KlluWGVi68cI-mQ>
    <xmx:CRA7atPNGSo1MPxVYtgOdWnoVKapsXHtjun7l4AFs_1tXlgk6-FHAw>
    <xmx:CRA7ahk8Ner8-vcIxeIlNIfczJPJCrSN8yNpO9V8s6eDSTkrAQHO9A>
    <xmx:CRA7agXydgi0WKGoFEaohVBUhknmUHaVnXh2Qe0ZJ0cPz7NPcx-xLQ>
    <xmx:CRA7agIxw7DNTpg5Fxv-5Fxgj5xnMytBpZNgBXHa16tZRs62qZZBTCu0>
Feedback-ID: i67ae4b3e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Jun 2026 19:00:24 -0400 (EDT)
Date: Tue, 23 Jun 2026 16:00:23 -0700
From: "Dan Williams (nvidia)" <djbw@kernel.org>
To: Srirangan Madhavan <smadhavan@nvidia.com>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Dan Williams <djbw@kernel.org>, 
 Dave Jiang <dave.jiang@intel.com>, 
 Davidlohr Bueso <dave@stgolabs.net>, 
 Ira Weiny <ira.weiny@intel.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 Vishal Verma <vishal.l.verma@intel.com>, 
 linux-cxl@vger.kernel.org, 
 linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Cc: vsethi@nvidia.com, 
 alwilliamson@nvidia.com, 
 Dan Williams <danwilliams@nvidia.com>, 
 Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>, 
 Vishal Aslot <vaslot@nvidia.com>, 
 Manish Honap <mhonap@nvidia.com>, 
 Jiandi An <jan@nvidia.com>, 
 Richard Cheng <icheng@nvidia.com>, 
 linux-tegra@vger.kernel.org, 
 Srirangan Madhavan <smadhavan@nvidia.com>
Message-ID: <6a3b100798704_3c9f100a9@djbw-dev.notmuch>
In-Reply-To: <20260623032453.3404772-9-smadhavan@nvidia.com>
References: <20260623032453.3404772-1-smadhavan@nvidia.com>
 <20260623032453.3404772-9-smadhavan@nvidia.com>
Subject: Re: [PATCH v7 08/11] cxl: Coordinate sibling functions for CXL reset
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Srirangan Madhavan wrote:
> CXL Device Reset affects all CXL.cache and CXL.mem functions in the reset
> scope. Lock same-scope siblings with pci_dev_trylock(), save/disable them,
> drain pending transactions, and hold IOMMU reset blocks until recovery.
> 
> Also include mem-capable siblings in HDM range validation and CPU cache
> invalidation. Cache-only siblings are quiesced, but skipped for HDM range
> handling.

PCI reset locking and ordering is already a source of some burden
without adding this new sibling model to consider.

Is there evidence that multi-function CXL devices, where most of the
functions are non-CXL, is going to be a common occurrence?

In other words if CXL reset borrowed the bus reset locking model:

    if (pci_bus_trylock(bus)) {
        pci_bus_save_and_disable_locked(bus);
        might_sleep();
	rc = cxl_request_and_flush_hdm(bus);
	if (rc == 0) {
		rc = cxl_reset_execute(pdev);
		cxl_release_and_flush_hdm(bus);
	}
        pci_bus_restore_locked(bus);
        pci_bus_unlock(bus);
    }

The cost is disturbing some non-CXL functions, the benefit is reusing an
existing reset order / locking model.
