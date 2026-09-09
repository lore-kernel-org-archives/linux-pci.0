Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5241F46E01A;
	Wed,  9 Sep 2026 22:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788991364; cv=none; b=jw64Vmx4A3DnCATtUYgf1cNqTXSXkWgzerNbBZiEwzEMGfccI8Ct+9qpDzahNlUU0RFZxb+3uolW0kKmsZxnzUByP/ww82SyeeNSfUF6eE5fRat8NXatygDkpQtz9Vy64gnWDe6mR+6J9usOpyfeAEuwIPOyO6XZnlHQn7Krg8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788991364; c=relaxed/simple;
	bh=sCM1UdrVbNRGe8PfPQDVzs0vs8uirXfGfgF4fMvEDRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P5W+3tT7qMiIDLk5CQwqcrZhjWFNOQdwx9mf85D9i0Vc43Sg0fAnuF4cnlYXYDkcuvXb96M7/k41k7tLbNndeKTeZU3n6hhPCwqYTuEdi8rZMkGkMDEWUzSU0o5QXYHs07Mosw64omsxNL2gopfnt7jUeELlXZIrZ2PXseiPqOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HArNKGdr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HArNKGdr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FC6D1F000FF;
	Wed,  9 Sep 2026 22:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788991360;
	bh=9Ns5qdS5KhAWIJwYEOIj/g7aHm6L5VzVzSnr8ej2zKI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=HArNKGdr1uF3nbg+gpRdcxPmNGb1HGPtwPsB3n2jhymOBQU5JEQQcW+/gHw2pKT4t
	 d2XsCG1NQFg9zXISmjnX6ZuV7ULxczpP3aTaHr8/2midh2wtm9QIgg16N55CeCxUW5
	 hkFKSaSvMNCP5PA9y0Q8shu+/jD4KcNc+ObuVXHv2D2f4VgD//9Ew0u/wnVjF+Rbeh
	 F71QLHoYalJHVZOBBK4If8e1ja0doLdAvw5YujhGwBh/G2KwQxvt5xgshWqQx42ZKP
	 O+L26dwvF8qg/HraokPwEKwDueXboPPkoCPf37Vf/kmqSbwCIpffkm1Vh7B4+3W+Vl
	 IocfQKWP9mTSw==
Date: Wed, 9 Sep 2026 23:02:31 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Bowman, Terry" <terry.bowman@amd.com>
Cc: Dave Jiang <dave.jiang@intel.com>, Alison Schofield
 <alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Bjorn Helgaas <bhelgaas@google.com>,
 Dan Williams <djbw@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, linux-cxl@vger.kernel.org, Tony Luck
 <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, Hanjun Guo
 <guohanjun@huawei.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Shuai
 Xue <xueshuai@linux.alibaba.com>, Len Brown <lenb@kernel.org>, Ira Weiny
 <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>, Shuah Khan
 <skhan@linuxfoundation.org>, Ben Cheatham <Benjamin.Cheatham@amd.com>,
 Richard Cheng <icheng@nvidia.com>, Robert Richter <rrichter@amd.com>, Lukas
 Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v20 1/9] PCI/AER: Introduce AER-CXL protocol error kfifo
Message-ID: <20260909230231.3fe72037@jic23-hlaptop>
In-Reply-To: <bb5a6b0a-c30b-4475-8be6-f3e3686c93be@amd.com>
References: <20260902133933.2992457-1-terry.bowman@amd.com>
	<20260902133933.2992457-2-terry.bowman@amd.com>
	<20260908015144.62ee9c1c@jic23-huawei>
	<bb5a6b0a-c30b-4475-8be6-f3e3686c93be@amd.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Terry,

> >>
> >> A subsequent patch wires cxl_forward_error() into handle_error_source().
> >>
> >> Add MAINTAINERS entries for aer_cxl_vh.c and aer_cxl_rch.c under the CXL
> >> entry.  
> > 
> > I couldn't immediately find any discussion about switching away from panic
> > on a kfifo overflow.  Was there a reply to an earlier version with a
> > discussion of that?  I'm not against the change but a 'why' 
> > here would be good to have.
> >   
> 
> The driver panics on kfifo full error during UCE enqueue. This was recommended by you and
> Richard. Changes are at the link below in cxl_forward_error():
> https://lore.kernel.org/linux-cxl/20260902133933.2992457-2-terry.bowman@amd.com/
> 
Panic on UCE is a given and correct. I ran the not panic on correctable via some
of our folk and they were fine with it (at least so far!).  I just saw that
you'd stopped panic on this as part of the change log and wondered why.

Not a problem, just following the breadcrumbs!

Jonathan
