Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793293128;
	b=t8zZdJwHj+6PKl2ifkSF82aTXvx4WaMxyINkFFzkpJ7lROYFivJ2/iZataj2h18xlmqX
	 cd8Y5KmO4gsb5pChKjjNWTX/tERaDeMLP50PW+qK80wV1ZzSw0eB+CbNF8j8sYkO4yK77
	 Vfcl6utvAL74X18yDNLPWepFqCcOSADuR2z/OUPlJMxzwYh/Z6hQCQoBacIxXP53ukM1U
	 6/GmIJmHlal/U2KUrGKlj9gFwYEF5zwhTbRo28MJlz7FZHs7AgYO9Lg9DSu1KBxTXrzZw
	 qjpcs8bteSDP+sUwT6moRCi7CBVq0TUwZlVgi0sWkiKxoZIrNLCGEOE8iW8EmilZ9Gw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793293128;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=6bXwD83MIjcipNSA+r7WlJ6caQoTXebpCKMfW1alQus=;
	b=BdzjvEQ8Kr6RdEpmpx3GFY1sQwAsnBDDiSmWjdXTuCHE1oC10boglA+nYHhlolzA3VP5
	 0zYMAzczYzB29LOpI3FFw1SEBADc5I7AB7kws8Q9t4q+mEIBDPdgoUZ87nxxlIsflNe7z
	 nYWCH+w1OO/Nqtr41E59J25rTT1gkTzAFkzeqT1Ln+oWuBSdHXSVz0HgigDOCEpcL+0S2
	 RHJ2mSwA9JwIRWmKHd1ZrUqNP5t2JILuCKZ2VKtS09z8d/D6A5Ji7TenZ7Iqy68lQtVDK
	 eA/4OqHlH8BFcBQt33ZPSzF2Zv86lStXyIdVgWiy9PBwvZ2cRkO82a3+k4op25PRMnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b="bD+Ng8/3";
	arc=none smtp.remote-ip=209.85.219.45
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3941606A31D
	for <linux-pci@vger.kernel.org>; Thu, 29 Oct 2026 16:58:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3941606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=bD+Ng8/3
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-917bab38b14so27335846d6.3
        for <linux-pci@vger.kernel.org>; Thu, 29 Oct 2026 09:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1793293127; x=1793897927; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6bXwD83MIjcipNSA+r7WlJ6caQoTXebpCKMfW1alQus=;
        b=bD+Ng8/3nCI/5cWKn4WtKDSPWVPk5hBHIuiXrkbElN6K0EOo4e5w1LTNRGXFCd00f3
         Jwfuew8Cj4qAcC63JhH+tGRH1YbHRvVxo6YW9k0/RoNCcXvNHdO3fsL+p7srQoYK9gCP
         dfIog/jvfA00buTc5IwNKM0mn0X83lr8anz+4kAo53fSHXwsNNNdjWFm0piYuWrBYoZT
         NEyIp44fVuFUY+ogZEPcdT044X6lvUV5KwJmKj0lUb1J7R9YDLAK8t4ELBxxSsUNCqeo
         tOzcJKDGtISKyS59KFnafl4w5KnGawAuTFyuO966T/FFgj03i6Xr3IlIcSNbesHZFjI3
         lwSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793293127; x=1793897927;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6bXwD83MIjcipNSA+r7WlJ6caQoTXebpCKMfW1alQus=;
        b=mYmEn40a5ivqSO6d9iBv/6d6bm34ZvCogpK2Lc9X90v5SeHhhM8FY0uWQ6onrmi6N9
         pkvUl+APWePF2Bqm0h2aSCHczO+KMhztZ6rx5hcYd8c2nSk4dVREbJAyceaz0Kj5ztTo
         07adJtzgmlDw637PusE6vnhCJUdtZLyTHYV1Y7doPy6V3f1fpdjbhQhSfDP51M9TAxmD
         KI/kz6SQw/Zd7hVV+W/k7T+wfDbrcGro41/InkcXVCrgJ2A//E7kJ3W+DnbNZ+UvfHHL
         1K0UJouxzG9dQDBVtiUZZnzWs09OZdFg5R2VEWBegDa+a7rycs75u33+o/PoYpv0R/h0
         5Xqg==
X-Forwarded-Encrypted: i=1; AKwUvBwEqI22ena4O46NNn/zVdyWCZ3T0tzeC5j6a36o2D1WikEK22jPxJGrYBGJXX+dpsZ4or4ZTl2m5b0=@vger.kernel.org
X-Gm-Message-State: AFq9FYJsvE+E41mUl194jigT2L4zK8d5FvhuDLHUWjDYDUENmjsg3zDB
	JPHjtV8dgQ3IuxzTcIxZbGdO5a/3KX7f3FHvcqAmW9/kUjII3O5fsoXxORVfFgVf4G0=
X-Gm-Gg: AYBFou0QZA5b6IloiKlFEG8tpkiABrpFUuGwgj2eIbNnRY2OHtl2uv0JoKZLdd32wDh
	SMezKvkqz+euMDnRRfwcTNB7f+se8pB0NyoDezs2fpmqbLaMcjxTDxka1zAlRpmqtnUI1FrseuF
	4/HdBAE03vZdHhExaV+4CkzEZH93f2wzRQJW/nAwRVG+/gsfUcxxtofN6N3cPjvm4ZXMcnnNLDs
	pEzvDOWxu+mfBHkxPxXs8ctN1E3skcm165U69SGwMuIED6JFPQT/UeP/rvTQ+xhubMGvMtqI6Wd
	bNuas2CBq9KtLTgCBZlORRRTbW91E9QofugYa2QWH9UvyI8gDHcpAZAeQru3t3SZ/7++Gr0VSU8
	Th+Q7OGQi/arsvTICRD/ugQYyiBGUMc/e1nITVVG7JTBAfFt9WZ84xPjO0SgXkZJhPF5D+SoJML
	K9PStsau0yYOGThsP4z3gecRVAdleO24IxbGKbeGkvNn2ud134RSQW5nfHxih5QQ9Us9nP+SbNM
	pswbEh8rJbedXzcSobi1EcYY1mSp2UZF24i+gOp7kJTZrkjJ6kJBTYD025kxv/JWiS+YiacV/hK
	iCWnawIo3cLQip5ZJWRzaan1+BCoBGKF1KTmQjd9yVsKwJ6KcGYdrE2g9fPQnIWOxS7CFvAmpsV
	mt++TlhV8RnDbmQQrZSqzjZ9ISRwW/lov
X-Received: by 2002:a05:620a:298c:b0:93f:38c7:70f4 with SMTP id af79cd13be357-94408aa100cmr927645385a.26.1793293126718;
        Thu, 29 Oct 2026 09:58:46 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-944209818c7sm8131885a.3.2026.10.29.09.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 09:58:46 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xMTSf-0000000G2uI-1sK7;
	Thu, 29 Oct 2026 13:58:45 -0300
Date: Thu, 29 Oct 2026 13:58:45 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Cc: alex@shazbot.org, pbonzini@redhat.com, seanjc@google.com,
	bhelgaas@google.com, jjohnson@kernel.org, johannes@sipsolutions.net,
	mani@kernel.org, lpieralisi@kernel.org, kwilczynski@kernel.org,
	robh@kernel.org, vkuznets@redhat.com, kevin.tian@intel.com,
	linux-pci@vger.kernel.org, kvm@vger.kernel.org,
	linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
	ath12k@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/8] KVM: add PCI MSI hypercall for VFIO passthrough
Message-ID: <20261029165845.GQ1685504@ziepe.ca>
References: <20261029163713.1366077-1-jtornosm@redhat.com>
 <20261029163713.1366077-3-jtornosm@redhat.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261029163713.1366077-3-jtornosm@redhat.com>

On Thu, Oct 29, 2026 at 05:37:07PM +0100, Jose Ignacio Tornos Martinez wrote:
> Some PCI devices (e.g. Qualcomm WiFi adapters) have firmware that
> programs MSI addresses directly into device BAR registers, bypassing
> the standard PCI config MSI path. When these devices are passed
> through to VMs via VFIO, the firmware programs the guest virtual MSI
> address instead of the host physical IRTE address, causing DMAR faults
> and non-functional interrupts.
> 
> Add a KVM hypercall (KVM_HC_PCI_MSI_ALLOC) that allows a guest to
> request the host's physical MSI address/data for a VFIO-assigned PCI
> device. The hypercall is dispatched from the x86 hypercall handler to
> a VFIO backend that:
> 
> 1. Finds the host PCI device matching the guest's vendor:device ID
>    using vfio_file_find_pci_device() (introduced in a previous patch)
> 2. Reads the host MSI address/data from the device's msi_desc or
>    by walking the IRQ domain compose chain
> 3. Returns the result to the guest via a GPA response buffer

This is not quite what I suggested, this still relies on the host
setting up the msi using the trapped MSI emulation, which is the
primary hack..

Was it too hard to make this an 'allocate msi' operation?

> The VFIO handler is connected to the KVM instance via a function
> pointer (pci_msi_alloc) in struct kvm, set when the VFIO device is
> created and cleared on release. This avoids a hard dependency between
> KVM and VFIO subsystems.

I feel like VFIO shouldn't be involved here, for the purpose of MSI
all we need is to inform KVM what struct pci_device * is at a vBDF and
then KVM can do the interrupt bits. Maybe this is already happening?

> +	case KVM_HC_PCI_MSI_ALLOC: {
> +		struct msi_msg msg = {};
> +		struct {
> +			u32 address_lo;
> +			u32 address_hi;
> +			u32 data;
> +			u32 reserved;
> +		} resp;
> +
> +		if (vcpu->kvm->pci_msi_alloc == NULL) {
> +			ret = -KVM_ENOSYS;
> +			break;
> +		}

Yet here it is called alloc?

Nothing should use vendor/device ID either, it should all be drive on
vBDF.

> +	irq = pci_irq_vector(pdev, vector);
> +	if (irq <= 0) {
> +		memset(msg, 0, sizeof(*msg));
> +		return 0;
> +	}
> +
> +	irqd = irq_get_irq_data(irq);
> +	if (!irqd) {
> +		memset(msg, 0, sizeof(*msg));
> +		return 0;
> +	}
> +
> +	desc = irq_get_msi_desc(irq);
> +	if (desc) {
> +		*msg = desc->msg;

And this isn't alloc, it is some query..

I think kvm maintainers would insist on a complete API here if this is
the direction.

I probably would not have selected this, it is why I suggested
virtio-msi or something that could be optional and seperate from the
core KVM guest ABI.

But maybe there is interest in doing it this way?

Jason
