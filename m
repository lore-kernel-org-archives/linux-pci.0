Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10617599A46;
	Tue,  8 Sep 2026 17:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788889647; cv=none; b=QvKMgnSk1GBubPfvhAlmc5zlkbm3xlLr9Y7JcI1z+MaXt0YKQXiMqWQOlVB/Qan0nIAKWbzKJjpZHFolowa7z1+/s0h6GmJYGRGZFndhBj0obWyIx5TzXFYxsK+yK1ffAtsTvlYcR0wpKhNIx/6/Rvm++iEgjMa7syk2EzZWWQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788889647; c=relaxed/simple;
	bh=nygTdh8fjI6CsKh6M1+ORwA70aR0m6XMje96txRY9JE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O7vSPSYKj5E66Ul+ECFCxIEksihRFkdKXxtZqEygkRFRpNUMn8Tw+BF7uL2/V3gHar+ccmbi57LwPV8rcoF3X2VhnvgYKh3ui3yxZ8qrUwQdefdqubHqrDF4TiQNAqZEvQKVdbLa5V1ncnr3s3D4rF36C5pu9GoPz0qPPhUtazw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z3f4f3xx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z3f4f3xx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4648E1F00A3A;
	Tue,  8 Sep 2026 17:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788889645;
	bh=qE44r8Wpvb2pGMbm3TYiV2/ToCaVSkA0bQ2RFs6wnI0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Z3f4f3xxYCQMcl1Hdk7nUEctePMOcq9JS++N3Nt/Ryh86AQqAlYIKGvzqGObYje0R
	 IL+Muz7ldanJo4IY/Es6GAhVOTbO6x33Nmh5MyN9ofQ50hc9IIt24+ih4Q0j6hkRUv
	 DC854zV53VOv0nuw0deVaZWSypIoEHWuy9SB7Zu5fxmTHnoEeSqtdjRepoqZnYFCyQ
	 3xRs/8rSFn5R2g6Q5u1HZ9kNrFgrpATLxpEtWlGHxheezJNJaFnoHTogrM0z6L+Hwb
	 ygKS/k/aNDttzRBZPky29GFafkQqEsqLA251WqEfQpP8rX4hpgyRyPMUZltLEtwIN+
	 Ej8ssbEwQ/ucA==
Date: Tue, 8 Sep 2026 18:47:20 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Terry Bowman <terry.bowman@amd.com>
Cc: Dave Jiang <dave.jiang@intel.com>, Alison Schofield
 <alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, "Bjorn Helgaas" <bhelgaas@google.com>,
 Dan Williams <djbw@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, <linux-cxl@vger.kernel.org>, Tony Luck
 <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, "Hanjun Guo"
 <guohanjun@huawei.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, "Shuai
 Xue" <xueshuai@linux.alibaba.com>, Len Brown <lenb@kernel.org>, Ira Weiny
 <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>, Shuah Khan
 <skhan@linuxfoundation.org>, Ben Cheatham <Benjamin.Cheatham@amd.com>,
 Richard Cheng <icheng@nvidia.com>, Robert Richter <rrichter@amd.com>,
 "Lukas Wunner" <lukas@wunner.de>, <linux-pci@vger.kernel.org>,
 <linux-acpi@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v20 4/9] cxl/pci: Thread port and dport through RAS
 handling helpers
Message-ID: <20260908184720.1d2e99cb@jic23-huawei>
In-Reply-To: <20260902133933.2992457-5-terry.bowman@amd.com>
References: <20260902133933.2992457-1-terry.bowman@amd.com>
	<20260902133933.2992457-5-terry.bowman@amd.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 2 Sep 2026 08:39:28 -0500
Terry Bowman <terry.bowman@amd.com> wrote:

> From: Dan Williams <djbw@kernel.org>
> 
> The callers of cxl_handle_ras() and cxl_handle_cor_ras() already hold
> a struct cxl_port * and optionally a struct cxl_dport * for the device
> being handled. Passing a generic struct device * requires is_cxl_memdev()
> to distinguish Endpoints from Ports at trace emission time. Threading
> Port and Downstream Port directly enables is_cxl_endpoint() and explicit
> dport/port branching for cleaner trace dispatch.
> 
> Refactor cxl_handle_ras() and cxl_handle_cor_ras() to accept struct
> cxl_port * and struct cxl_dport * directly. The CXL RAS trace event
> emission logic is split into three branches: Endpoint events are
> identified via is_cxl_endpoint() and emit with the memdev, dport events
> emit with dport->dport_dev, and Upstream Port events fall back to
> port->uport_dev. This branching is transitional: the follow-on patch
> ("cxl: Add port and dport identifiers to CXL AER trace events") unifies
> the trace events on port/dport and removes it.
> 
> Update cxl_handle_rdport_errors() and cxl_handle_proto_error() to pass
> Port and Downstream Port to the refactored functions.
> 
> RCH Downstream Port correctable trace events now report the dport device
> (dport->dport_dev) as a consequence of threading Port and Downstream
> Port through the RAS helpers. The following trace event rework ("cxl: Add
> port and dport identifiers to CXL AER trace events") adds explicit memdev,
> Port, Downstream Port, and host fields that provide full context for all
> device types.
> 
> Co-developed-by: Terry Bowman <terry.bowman@amd.com>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Signed-off-by: Dan Williams <djbw@kernel.org>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Subject to Ben's question getting a reasonable answer,
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

