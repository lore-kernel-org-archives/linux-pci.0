Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5EB26738C;
	Wed,  8 Jul 2026 18:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783534256; cv=none; b=t8MYEsG+L1bLEjFH9d8Gyy3ksR+VG5FeFT8i24q43lfICG7BYJYZw4TL5xpP5JB9hxXtL1WEZDxXuLCJyWMmVTc2KL7kCDpY/PfOC7L4t1mSvXfISrCBnnrhzKcqR9wuLt9lGLzAdIXoKz4ZUw1BTcwahD+ym1Rdw39zwFYIAA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783534256; c=relaxed/simple;
	bh=fnp4hjD4vAvN1iPlyPNMRGMFy3uhs3EJRNk5VDagrgE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KVwr5VrwDQWF2QIgpRqV4xFhCa36dipYqLGdp8IqpmdeXgf9nd9c6jj/4KSIHURqazdl+Nwnfh1XUfL99UsIhmjZcF9nVSQ+gNy1kC8trHI1/vJ0tWsgkCnxj1gwXZKj9FEYqNSHwvb40UOd9eCIcOcyXHLoPTYWNJ/6lrjL+zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DciOms8k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DciOms8k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ED011F000E9;
	Wed,  8 Jul 2026 18:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783534255;
	bh=CnX2923KGzSLrC36YmQvfB3mbK6YxMnAcdqy7AJr87o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=DciOms8kkeWeV/xdNjzGuDDA9XesCXr4+AW43/fsvEDr5ytYfKCX2oBbNC7rRL7sZ
	 LG2OJcskFYh81Mv2hdxl5+w6OE+MuibzPmv+vKtLUZFZRMI2cwFWSJ3jd8xJpOwupE
	 atMn3jfBUGyr1+/m3xrezOPI0XCIryhZT9aRJD84ZrlCeD0RdJTXh+AX0sK9TQRZoy
	 OKQw3ny/SVQLAynbGaB3c+N8rLYJgSF3B94BoLbOooYuxgNFxHNGfG+akmt05wFVmb
	 zL4CmUMh9LvvQPOT4hvrR999ejJMyymm+wkJy79Av7AJzOo3ojq3KXDGUnB7LiOZv2
	 Ok/MpbPfrB9YA==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: "Dan Williams (nvidia)" <djbw@kernel.org>,
	Dan Williams <djbw@kernel.org>, linux-coco@lists.linux.dev
Cc: linux-pci@vger.kernel.org, driver-core@lists.linux.dev,
	ankita@nvidia.com,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dexuan Cui <decui@microsoft.com>
Subject: Re: [PATCH 13/15] PCI, device core: Add private memory access for
 DEVICE_TRUST_TCB
In-Reply-To: <6a4e91aabfeb_2f05d5100da@djbw-dev.notmuch>
References: <20260705220819.2472765-1-djbw@kernel.org>
 <20260705220819.2472765-14-djbw@kernel.org> <yq5aa4s4i91v.fsf@kernel.org>
 <6a4e91aabfeb_2f05d5100da@djbw-dev.notmuch>
Date: Wed, 08 Jul 2026 23:40:47 +0530
Message-ID: <yq5amrw1gxnc.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Dan Williams (nvidia)" <djbw@kernel.org> writes:

> Aneesh Kumar K.V wrote:
>> Dan Williams <djbw@kernel.org> writes:
>> 
>> > A device that wants to access private memory needs to have its trust
>> > elevated to DEVICE_TRUST_TCB. That trust is established either at compile
>> > time (unlikely), the bus knows the device is within the TCB to start (some
>> > paravisor setups), or the device is dynamically added to the TCB in
>> > coordination with a TSM driver (primary TDISP use case) and the trust is
>> > elevated by driver match.
>> >
>> 
>> 
>> Do we have the last case, where the device is dynamically added to the
>> TCB in coordination with a TSM, implemented in this series? Do we expect
>> the CCA driver to set that up?
>
> In this case "dynamically added" means pre-existing device converted
> from shared to private operation. I.e. the model the work-in-progress
> CCA patches already cover if that was your question?

So we accept the device and then load the driver with trust=tcb ?. If not,
where do we set the device->bus_trust = DEVICE_TRUST_TCB? 

-aneesh
