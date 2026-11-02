Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793631530;
	b=f2CoRZ9t2pSopjl/cWvqfMC9jN/5BNs9gIPnN7Coqmy94uwZU+gPGNeS/P4nVAelX35C
	 g7oplgTM5mOpSsGx9su1+jrLGd/5P83n1eYmjNMDVP8qLQG+FABc1k+VznmrFQDcz+B6f
	 V2iFVZu8ySHyqj1YxRjbmqcf8XGDUKWPbzi8DBNy08mlmBC4CUeZyZFjVBvRqlNJCzIf8
	 f4Mva9Nls616wDjVoRuRJMEDBN/PDGxR1P4cKYoklLxpdf0R97fdhhKrAY8XtS98y1a/k
	 XDyVirSYPjgqUK+yCrM/dAksYK7P+nWPaHG7qHAlXdZ4xW0QZbAPy6F2jkkYKvR5esg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793631530;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=BGZaLVl/bf+VQNDSvC9YaFRzMNQ+JkOw52QT0TU0FxI=;
	b=zLgm0dYsfbQKQI5fEqtCMWhYkkxaA7rKIWl+4k++nzmlaAL2x+ltxzwmhgwliyXF32oB
	 mN6/ErOdOC0W0KwprBBhZWn9ilgjVw+f0UARiwBcAx3wRwACrWyhaR3tiW+OyuaUgs841
	 fkqfXmvKrLmDUx+VyxXfjX0cYZprXWN+mO4vx9X/3YWVFE9geqNTByDwrRIvuD82S/Z2a
	 qa694KT0smnmzMlY4E9pxsXfJMFas3+dZ8acf4K2yxti3TvIHolo51HYMZFfhAUMRrTCG
	 GbKX9U2DYb8HvvbEcpch0NRNJ8HYav/bVCJt2LUgbmj2ZXd1XkbMvUjtDsCzP1zTrPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=TZywBXE3;
	arc=none smtp.remote-ip=209.85.214.197
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE20606C3D2
	for <linux-pci@vger.kernel.org>; Mon,  2 Nov 2026 14:58:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EFE20606C3D2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=TZywBXE3
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2e869e00005so49284795ad.2
        for <linux-pci@vger.kernel.org>; Mon, 02 Nov 2026 06:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793631529; x=1794236329; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BGZaLVl/bf+VQNDSvC9YaFRzMNQ+JkOw52QT0TU0FxI=;
        b=TZywBXE3oo1AuLBH7fBdMETQ/ZJUgYCO5nOgYZhMM2/RSWMHeOnBsVWpkN2kAt7KvD
         74dzAt9PIPbwp/6+RUsGUMXtWVUoMV3MdAigrrJIZiU/oT21l+cUq8atuQ+RAalmSlHk
         g3RJ7DyQkTdkIAvVBxgZUe0Sz810/Xb582RtJwJCvscY3ni5bJfSTeCbvv+C4vp62UV3
         an0957++A+LpFnNFNacx9MYI7lnZMrH8MOcXyiWyZ5j8n9FueDIB/nvRaAJodCsoUOg1
         oMXcKKC21ctT7VDibGCwQcUAZ00IKICYtJZusuhXMeMnt4qTZRFqLClfq3HFOkmznWQ7
         q4pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793631529; x=1794236329;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BGZaLVl/bf+VQNDSvC9YaFRzMNQ+JkOw52QT0TU0FxI=;
        b=xU/Sy8xbavCcdc1i3MBFmfhJ9Gd9nk2y0lUxG2qV8aIVBuzmhrUCuf8SNL6eZb85Oi
         5M/oT+jatPPTz/ketHvTk60IvhxI5WvEqui7pQSxdr09qMG6vjN3NFpIgyYkgsZBO7Zg
         tPaUNfAUoySsPJQ2s97I2JpRQj2Zlj6vpoN4lO9BkzLb0CiGRto2zWKXRmSLaxSc/bZc
         TmL/EBNPSlOH6RKl447Lz0YTpCfKmhYPixC0OaY+OezOQMGE4Co6XPhB/qRA7SGCyWCd
         dLmdwOW3/ExH2lRtlHCbNlNU9Vv+lp3p0xVVzqTQ6a05bLSlYUCDEAbRn+0LkU2XDM7o
         fMVw==
X-Forwarded-Encrypted: i=1; AKwUvBwxEUqfQTXKcYYTH/iVJXhcnOC3vxsqeetIfPyQPb02Vhv7aJjd1jZvfmfYteDzjPxdqA5OIpgKNPk=@vger.kernel.org
X-Gm-Message-State: APuU4Z/upvenmjt8YEAD/h5dz4OWLR80Qqj2lN0ISdkhZrBzO5Mxrta+
	T4zNG1zHz7/rSGxhvyuY8KwwK29f3C0ImTjCBzMH0TMDcpETNIQ3UT+tsBIBjlALOeuANqgeTM5
	TZtVosg==
X-Received: from plnl5.prod.google.com ([2002:a17:902:fd85:b0:2ea:44fa:2c44])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f691:b0:2e2:d39f:182f
 with SMTP id d9443c01a7336-2eb3643d489mr99134825ad.28.1793631529137; Mon, 02
 Nov 2026 06:58:49 -0800 (PST)
Date: Mon, 2 Nov 2026 06:58:48 -0800
In-Reply-To: <20261102074657.27715-1-jtornosm@redhat.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261029165845.GQ1685504@ziepe.ca> <20261102074657.27715-1-jtornosm@redhat.com>
Message-ID: <auilKFwKLjw-BnZM@google.com>
Subject: Re: [PATCH v3 2/8] KVM: add PCI MSI hypercall for VFIO passthrough
From: Sean Christopherson <seanjc@google.com>
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Cc: jgg@ziepe.ca, alex@shazbot.org, ath11k@lists.infradead.org, 
	ath12k@lists.infradead.org, bhelgaas@google.com, jjohnson@kernel.org, 
	johannes@sipsolutions.net, kevin.tian@intel.com, kvm@vger.kernel.org, 
	kwilczynski@kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-wireless@vger.kernel.org, 
	lpieralisi@kernel.org, mani@kernel.org, pbonzini@redhat.com, robh@kernel.org, 
	vkuznets@redhat.com
Content-Type: text/plain; charset="us-ascii"

On Mon, Nov 02, 2026, Jose Ignacio Tornos Martinez wrote:
> > I probably would not have selected this, it is why I suggested
> > virtio-msi or something that could be optional and seperate from the
> > core KVM guest ABI.
> >
> > But maybe there is interest in doing it this way?
> 
> Since there was no feedback from KVM maintainers,

NAK to adding any KVM-handled hypercall, and probably NAK to any approach that
requires KVM changes.

With regard to timing, please show a little patience and awareness.  It's Monday.
You posted a fairly large series on a Thursday, during a merge window.  If you
change direction after ~2 days for a series of this natures (touchs multiple
subsystems and introduces guest/host ABI), you're likely going to end up with
severe whiplash.
