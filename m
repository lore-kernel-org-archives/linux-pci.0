Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4223909BF;
	Wed,  5 Aug 2026 14:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785941554; cv=none; b=HBkR5f7HlVyjaJLcQjD/1m2gL5BaqnJliQRNhT5SCrQORyHiT5H+oeGSxkDwyTZmE3Ktcxcwc93XB+b564bIJs97rkmVg0rPWhfqtbM5SuTt7NzIsix0PIocgAxgX54Fwh9vBxNdKbR4dmHvC4SPxBILT5/Qu0iXQzTjUQWqlNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785941554; c=relaxed/simple;
	bh=V1vMFzvbpOsVqDlP1F4HLLpMA2iy2wrtQgeOlHIvRcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UrL4nTPLaMudkgnowJxqSe+IFE9njwZaXkH32LLWvl67nqOklFTN9/hjEffnvlTQDBIkHtx1Qn5EoVUnuqM3bjtNw92Yl62gG7bxfchlcMrUzx52oqRD9WjmWzF8oiUIFdcsfA35jL6rK/14BIwr3gWUxbrGCwC3gpjjrsbCouM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uz8Jmq8v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uz8Jmq8v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66E271F000E9;
	Wed,  5 Aug 2026 14:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785941553;
	bh=ELhK4rl+r13PV2J/cKV8h4IXQk1HnwLW6SsE62SCcCM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Uz8Jmq8ve7/kkG2FNZKGvCTlvZLhpZJNbpuNuiR00/q4ZAOZwbCJtTDPFum/EvPJr
	 IoxlHVX9XwcRfu469CsXQXFQAsuPocPub8051e5AERbZ1txkdazoqga4YTZ7XJoSe0
	 EDSNuYANVeoppZFogTtSFraeg0t0PS+bOzPuSg/ZnQD0xHNAwxrf5j9ZOBOQwBpMmc
	 4oTVyre+fKRpMkXJdzlrykf1ZF8/lZU9IlLJdCJe45GMhfvEqd3+c3AkmKtIzRezbU
	 WCKixfhHoJWNTxojv61gU1PhFMm+HYf9Ogy4EKe8MytMpUjB+yCVhZiEIrarY5i3gi
	 G5X493ZKh+ApQ==
Date: Wed, 5 Aug 2026 16:52:15 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rahul Samana <rahul.samana@oss.qualcomm.com>, 
	Bartosz Golaszewski <brgl@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, Rocky Liao <quic_rjliao@quicinc.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-pm@vger.kernel.org, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com, 
	quic_anubhavg@quicinc.com
Subject: Re: [PATCH v2 1/6] dt-bindings: bluetooth: qca: add QCC2072
Message-ID: <5tkajres2vjkt436teaujcqyc3mjqr65rsfvwhjbmlk3fc3gpt@j6ozyfattae3>
References: <712f8a14-d2a1-4a90-82f9-05cd694f2658@oss.qualcomm.com>
 <c1875dd6-fe3a-4a69-a6fd-b461c8fba6e4@kernel.org>
 <6d6465bb-47ac-464c-af4e-0ca72325705f@oss.qualcomm.com>
 <8a388310-d3cc-4d02-abb6-0eb98c24cfce@kernel.org>
 <4523441f-498a-4bbd-80f3-97a7a9206c00@oss.qualcomm.com>
 <6e0b9e79-ccd4-4689-9a6b-9b4fc556d5e4@kernel.org>
 <gfhlyvoefcsvtjuxfo75qeham272cc5g2r3npjenzs5esjifiy@ro7dtkpxwizk>
 <8ab6c26f-b648-447c-9fdd-f1424beb44f4@kernel.org>
 <sewfntbhqtj2apfdi4ouan27artvj4lyxqizvinsvzltbofqu2@riuoo3fmczff>
 <768142f0-2638-41f3-a34f-dc80bb99eb7f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <768142f0-2638-41f3-a34f-dc80bb99eb7f@kernel.org>

On Wed, Aug 05, 2026 at 04:36:31PM +0200, Krzysztof Kozlowski wrote:
> On 05/08/2026 16:12, Manivannan Sadhasivam wrote:
> > On Wed, Aug 05, 2026 at 02:33:51PM +0200, Krzysztof Kozlowski wrote:
> >> DT is not representation of internal device driver instantiation mechanism.
> >>
> > 
> > Here, the driver is just creating compatible for a real device. What difference
> > does it make if the BT node was defined statically in the DT vs created
> > dynamically? Both nodes do represent a real BT device, not driver's own
> > representation. And by the time the node was created, the device is physically
> > attached to the system.
> 
> What stops this power sequencing drivers, after more driver patches, the
> best if being part of some bigger series, to add properties like
> "linux,name-of-driver-to-bind" or whatever other SW properties?
> 
> This is what happened in that linked thread:
> https://lore.kernel.org/all/20260326-pci-m2-e-v7-8-43324a7866e6@oss.qualcomm.com/
> The driver code is adding children under other nodes (references by
> graph) and it is nowhere documented. Maybe bindings of these other nodes
> allow it, maybe not. How do you even validate that?
> 

So the concern is validating the properties that get added dynamically and I get
that. How about inserting an overlay for the BT node instead of creating the
node on the fly? Like, drivers/misc/lan966x_pci.dtso

This way, the overlay would be validated against a binding and the driver would
just be inserting it.

> So answering your question - yes, there is a difference because:
> 1. DTS we validate but whatever you add to driver code we do not and we
> cannot,
> 2. DTS represents hardware but whatever you do in your driver code
> represents who knows what (maybe hardware, maybe not, can represent
> anything)
> 
> And if you claim "I add hardware in the driver!", I respond - maybe
> true, maybe not, but look at this crap:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=687bfbba5a1cb15cee51519c210141ed1c4b0ec7
> 
> Since we DISALLOWED venus-decoder and venus-encoder DT nodes, what did
> Bryan do? Squeezed via driver code fake disallowed nodes and even gave
> them compatibles not looking like compatibles, so any regex won't work.
> 
> This power sequencing work here has the same problem of sneaking ABI,
> which I pointed out here:
> https://lore.kernel.org/all/9cc5af16-d95e-4f10-8b4a-5e29c136079c@kernel.org/
> 
> Look at above patch - nothing documents that ABI. The same as Bryan's
> fake venus-decoder and encore (not only fake but actually rejected). And
> to avoid ABI-check tools (or incoming tools), this power sequencing code
> does not even call a "compatible" a "compatible". No, it calls it
> "driver_data" nicely avoiding detection.
> 
> This is terrible practice and I feel like allowing this patch is silent
> acknowledgment or agreement of such practice.
> 
> It's about basic ABI principles - if you have DT ABI, it must be both
> clear in the drivers code and in DT bindings, instead of obfuscated
> calling a compatible driver data. If you don't, then this is not DT ABI
> and you are not allowed to use OF code to instantiate drivers. Use SW
> nodes or KHO-style whatever else is there.
> 

I did propose using SW nodes initially, but then it got changed to
OF_DYNAMIC with review from Andy. But honestly, Andy only mentioned 'DT
Overlay' [1], and I was the one decided to use OF_DYNAMIC.

- Mani

[1] https://lore.kernel.org/all/aWSwgRiEkT9unYw9@smile.fi.intel.com

-- 
மணிவண்ணன் சதாசிவம்
