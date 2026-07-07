Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com [136.143.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965F841DED1;
	Tue,  7 Jul 2026 13:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783431702; cv=pass; b=kptfAPXYGaScAmDEHnYZUGAVQ4l2AaTe1XvHAx8BJNCPo4CcGCfkYfGzSsE8ITsi/645pVUXripOnQ4zA9PSiHkj2jvEH3X995vJYZpYrbMXhkeKOXr/ZojSVMeF0r70rdDpiwFscAt+Fnb3cmxMYT+TeMeKQHidVgNgfwqZsvM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783431702; c=relaxed/simple;
	bh=FU8IpKv0vuIMwTzRexzVzQSriwxFDJetoGck8Yt6WIQ=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=eOds1IFNeuR0MPpv2IKolVXU1/DgfKqmwCePJE74DfkjeqplX2Wdx8yyHg+yL/KEtgEguF6yG5f66E0Tz39f98jTeviH+Tosa5324KNNAEOCIiKsUSFWbQnEWtUBzBTCzngKszitvBa+Ua0TpdagXZjiWrhOKQB65i+g6NuYSnM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=FApBuHV6; arc=pass smtp.client-ip=136.143.188.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="FApBuHV6"
ARC-Seal: i=1; a=rsa-sha256; t=1783431666; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=XC+2V+tF57fhHqiEqEMeN4+3ze9SKmVAVP0QP1HgED9o13x5375ZXp35PQSQhIjABHeH2ZtCzrJHMPcCpD9BnMXIFP4xakgv+Xk6GUddF04hXkPYF55Wj7hF5Pl15SUJmOk5sWCgYkHDxqm5n5oVW7QjusdbTdArHyC51t5H4A8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1783431666; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=8yJI/88EdX2GRQCqqS4z7ecymFyxnXoCVWINXnFUUII=; 
	b=LxwLFH2g7Wp9k1kzaqFUA50tK5VRWfwcV2eAq6yQaqjpEN4ENq2SP0rN7uUfP3b8MOLGIU7kP4eN05jgqDn0+SKcb6uARotluMePG4/lVxnWaOD7VmiTvrR0D9N6PLjs43rm5TtC8ceMpIPGBXcDy7+4qonE/VW9Dw+S/2kmzKc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783431666;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=8yJI/88EdX2GRQCqqS4z7ecymFyxnXoCVWINXnFUUII=;
	b=FApBuHV6X+zptFGteZnC68GJA29gc+JO/hWzT1hi0+QWZ7rFeC9jKrrjg7MZqX+k
	W3p6nkUw8hYVw6pUMsO8FO3qIUXOjAJS9zPadpLu+F4MC+54ji/m3WsSGNvrq3Pe9WM
	Ap7kGJmJTl0OtePfxjf0W46HmjfWMcprSRZZwsTw=
Received: by mx.zohomail.com with SMTPS id 1783431665326190.71904984304115;
	Tue, 7 Jul 2026 06:41:05 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH] rust: irq: make Registration compatible with
 lifetime-bound drivers
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20260703210936.1128698-1-dakr@kernel.org>
Date: Tue, 7 Jul 2026 10:40:44 -0300
Cc: aliceryhl@google.com,
 ojeda@kernel.org,
 boqun@kernel.org,
 gary@garyguo.net,
 bjorn3_gh@protonmail.com,
 lossin@kernel.org,
 a.hindborg@kernel.org,
 tmgross@umich.edu,
 tamird@kernel.org,
 acourbot@nvidia.com,
 work@onurozkan.dev,
 bhelgaas@google.com,
 kwilczynski@kernel.org,
 gregkh@linuxfoundation.org,
 rafael@kernel.org,
 mhi@mailbox.org,
 driver-core@lists.linux.dev,
 rust-for-linux@vger.kernel.org,
 linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <49636EC4-885A-47D3-9A42-12493A72DD30@collabora.com>
References: <20260703210936.1128698-1-dakr@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External



> On 3 Jul 2026, at 18:09, Danilo Krummrich <dakr@kernel.org> wrote:
> 
> Adapt the IRQ registration to work with the Higher-Ranked Lifetime Types
> (HRT) device driver architecture introduced in commit 2c7c65933600
> ("Merge patch series "rust: device: Higher-Ranked Lifetime Types for
> device drivers"").
> 
> With HRT, driver structs carry a lifetime parameter tied to the device
> binding scope, allowing device resources such as pci::Bar<'bar> to be
> held directly rather than through Devres indirection. However, the IRQ
> abstraction required Handler: Sync + 'static, preventing handlers from
> embedding lifetime-parameterized resources.
> 
> Remove the 'static bound from Handler and ThreadedHandler and replace
> the Devres<RegistrationInner> indirection with direct request_irq() /
> free_irq() calls in the constructor and PinnedDrop.  Registration<'a, T>
> stores the IrqRequest<'a>, which structurally ties it to the device
> binding scope.
> 
> Also remove the &Device<Bound> parameter from the handler callbacks,
> since handlers that need device access can embed it in their own type.
> 
> IRQ handlers can now directly own device resources:
> 
> struct IrqHandler<'irq> {
>    bar: pci::Bar<'irq, BAR_SIZE>,
> }
> 
> impl irq::Handler for IrqHandler<'_> {
>    fn handle(&self) -> IrqReturn {
>        let stat = self.bar.read(regs::STAT);
>        ...
>    }
> }
> 
> This eliminates the indirection previously required for IRQ handlers to
> access device resources and aligns with the broader goal of expressing
> every registration scoped to a driver binding through compile-time
> lifetime bounds.
> 
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> 

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>

