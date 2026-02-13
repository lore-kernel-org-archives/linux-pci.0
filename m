Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4D535FF61
	for <linux-pci@vger.kernel.org>; Fri, 13 Feb 2026 14:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770991309; cv=none; b=qYQKF5v1+ci9OBJf9nihX1+flP6s9lHFc/iAiVyWEOZSOuJRUPzrT21Oy9mGJ0ktU5VQw/qt6xx6ki1JfFL5i7PYncguEWoCkmIq44iLwWsQE3AWC5QUiDC4JQc2cp4vTfJ00DGlOUubB3yMi2bssIX4qkg6+lLMY3646ZTCcD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770991309; c=relaxed/simple;
	bh=KerO4Jrj/TAWD+Q1M8pAwvV3iWXUR19CillnJoxpBb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qGQbAEewcz5VaJxMVx+NWQUIgsTzrim2AY7vmXM7Vip+n5MFgST/cEwh88nuNx9UHTFEv6F2wfV5xBJXdrrSepzJCSf1q3HfXkdr416UPiXUMAfHpjQgtnUhDX1mm67f50ngthCXSQ1wPFGf1B5pQPHO6pR6aVQ/JuWvyWiIoSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H4VOP+dp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H4VOP+dp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C02B4C116C6;
	Fri, 13 Feb 2026 14:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770991309;
	bh=KerO4Jrj/TAWD+Q1M8pAwvV3iWXUR19CillnJoxpBb4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H4VOP+dpdiuUdp6m8agLkv0iwKUiK2xkiFfC4Ywe82wB01LSjx5EtuvKRAkOCkiFh
	 ZtB5eUJfPbTHalN0H36A9hlX2rK9Jn4x8dGOrlS24o+oPsmz6tKr5wD0yfyT0zq6m1
	 pfb4hR1of/UU1dXOYDrBQxB4s9oKFdAl3e9ZhQdWCN4RKB59Y3O4j7sEPXh9VdFnx+
	 vjfEQ8K8nuDJNRdSYjbWd0+dmnw4wXLFuER2CZw01gUqeXKoQIVFBQCQnLEKn+QyOL
	 vtXeTrunC/S3KkeEWukgzh6CPi8VTISYkL+h5+GgXymeQ0Vxs2Ea/U4gE1U0wZ4izX
	 EOI+Uw+gr1+tA==
Date: Fri, 13 Feb 2026 07:01:47 -0700
From: Keith Busch <kbusch@kernel.org>
To: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Danielle Costantino <dcostantino@meta.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI/DPC: Clear Interrupt Status in dpc_reset_link()
Message-ID: <aY8uy9BZyLMYgKua@kbusch-mbp>
References: <20260212191818.3625264-1-dcostantino@meta.com>
 <20260212191818.3625264-2-dcostantino@meta.com>
 <9b75cf12-a0b4-49bf-b261-cbe02c0fe310@linux.intel.com>
 <aY5E4OWE_v0Jdyd1@kbusch-mbp>
 <9a7a176d-4450-47ac-859c-0ce69a19afee@linux.intel.com>
 <aY5QMlr_7XLIbOsV@kbusch-mbp>
 <8b4800cf-7e8a-42f7-a84a-5081afe00048@linux.intel.com>
 <aY586W1YoKVyfBJZ@kbusch-mbp>
 <bf28da73-7189-412f-808a-2dbb6d241b4d@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf28da73-7189-412f-808a-2dbb6d241b4d@linux.intel.com>

On Thu, Feb 12, 2026 at 08:28:15PM -0800, Sathyanarayanan Kuppuswamy wrote:
> Hi Keith,
> 
> On 2/12/26 5:22 PM, Keith Busch wrote:
> > On Thu, Feb 12, 2026 at 02:51:46PM -0800, Kuppuswamy Sathyanarayanan wrote:
> > > On 2/12/2026 2:12 PM, Keith Busch wrote:
> > > 
> > > As per EDR flow, firmware waits for _OST reply from OS to complete the
> > > current interrupt handling. After receiving _OST, firmware decides whether
> > > recovery should continue or if the link should be disabled. When/how firmware
> > > handles subsequent DPC events depends on firmware's implementation.
> > You at least agree the OS controls the "Trigger Status". That controls
> > whether the link stays contained or not, but now you're saying the
> > firmware gets to yank the link after the OS returns _OST success?
> > There's no flow in the spec suggesting any such behavior.
> 
> I was referring to the flow chart and notes on page 85, in PCI firmware spec,
> v3.3, which mention firmware can choose to disable the link in certain
> cases (notes 3,5).
 
Err, what? No, there is no path for firmware to disable the link if OS
returns _OST  0x80 (success). The path says firmware is supposed to
"Clear ...  Disable Link", not to disable the link.

If the firmware wants to disable the link permanently, it does so before
considering DPC and makes it a hotplug event instead.  

But in all honesty, that diagram is a complete mess and very poorly
captures what an OS is supposed to do for a DPC. You don't unbind the
drivers when you're trying to recover the devices they're driving.
