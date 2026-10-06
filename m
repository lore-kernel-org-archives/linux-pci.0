Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A815E46E007;
	Tue,  6 Oct 2026 15:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791299130; cv=none; b=flKSpXrr+Ec4n9l/4DTJW1Mh1GP5x8eXLfo/aDlx1QPq+Rcx9UD6jfYkhXedsStnMOMbXWyM7CkeyDYhNcYCNTNBD0Tm7z+wajk7OpHhNtXejM0SdynFX04U5jnYEf4S9cRrOfwA7VclMTkZ3lN6aPu0B6CLIKEVKNbYTpUuy3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791299130; c=relaxed/simple;
	bh=kywWPPUkRrL4Ls3U6xiUZCF49pQdQ4WNb0YLEU8SD5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m6YVf99ltW4E0RMTjYeyLzPtxt4EtUUbzM01YrBulydBGbHJjMWcR4gWVq6a0lkUO5ijfTpzjlX4Rn2je9wknu7+MtVZMDtbdpNrsr/vimvk7oHmA9rP79dJbNm3GXI/iZYrcXYlgBUJEEECyF1vH4/7NYGPVF5hA4NPjdrywDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kyHZtuH+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kyHZtuH+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16E8B1F0089B;
	Tue,  6 Oct 2026 15:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791299129;
	bh=hBqFdznuLd3hjEwdeyX6wxG7qA8UaM4e75ldG5AnVMg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kyHZtuH+FP9Kiatn9EU+MxMJ9YMK/tjec/fNEotp8ZykFRq4e/RGG1/ISWwLjlCyC
	 xJzurq7kFCpyzybl8cOhnEtKTZa/CTshXKO66+4ESF/E3geFruNz3swKCHV5VtIgs6
	 NWdfOQUUaBwjZ+/u1wZSjumOSM0xXYyxO0RtJPfgICNKga7POHHWXY87J0s5e3TSmT
	 Mu8hrXnqiAVBsDgBXHdoPZYIdQpmvC39TFEHEsrPh816BWa9HZQzWWtIIwcRAOW1lr
	 49uJQQwONgadWKq6DHjEqhEc0+RI/nr9bREDlCuURtQX+VM/mOA6O+t2zOQ10Q5Tng
	 th1I+GZtq5zxg==
Date: Tue, 6 Oct 2026 10:05:28 -0500
From: Rob Herring <robh@kernel.org>
To: "Musham, Sai Krishna" <sai.krishna.musham@amd.com>
Cc: "bhelgaas@google.com" <bhelgaas@google.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kw@linux.com" <kw@linux.com>, "mani@kernel.org" <mani@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"cassel@kernel.org" <cassel@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Simek, Michal" <michal.simek@amd.com>,
	"Gogada, Bharat Kumar" <bharat.kumar.gogada@amd.com>,
	"Havalige, Thippeswamy" <thippeswamy.havalige@amd.com>,
	"Sanwal, Pranav" <Pranav.sanwal@amd.com>
Subject: Re: [PATCH v7 1/2] dt-bindings: PCI: amd-mdb: Add CPM6 support
Message-ID: <20261006150528.GB2194299-robh@kernel.org>
References: <20260823040715.204096-1-sai.krishna.musham@amd.com>
 <20260823040715.204096-2-sai.krishna.musham@amd.com>
 <20260917192515.GA3283677-robh@kernel.org>
 <IA4PR12MB9810F0345A3E7A7D3F28ADCDCD952@IA4PR12MB9810.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <IA4PR12MB9810F0345A3E7A7D3F28ADCDCD952@IA4PR12MB9810.namprd12.prod.outlook.com>

On Tue, Oct 06, 2026 at 10:01:31AM +0000, Musham, Sai Krishna wrote:
> AMD General
> 
> Hi Rob,
> 
> > -----Original Message-----
> > From: Rob Herring <robh@kernel.org>
> > Sent: Friday, September 18, 2026 12:55 AM
> > To: Musham, Sai Krishna <sai.krishna.musham@amd.com>
> > Cc: bhelgaas@google.com; lpieralisi@kernel.org; kw@linux.com;
> > mani@kernel.org; krzk+dt@kernel.org; conor+dt@kernel.org;
> > cassel@kernel.org; linux-pci@vger.kernel.org; devicetree@vger.kernel.org;
> > linux-kernel@vger.kernel.org; Simek, Michal <michal.simek@amd.com>;
> > Gogada, Bharat Kumar <bharat.kumar.gogada@amd.com>; Havalige,
> > Thippeswamy <thippeswamy.havalige@amd.com>; Sanwal, Pranav
> > <Pranav.sanwal@amd.com>
> > Subject: Re: [PATCH v7 1/2] dt-bindings: PCI: amd-mdb: Add CPM6 support
> >
> > On Sun, Aug 23, 2026 at 09:37:14AM +0530, Sai Krishna Musham wrote:
> > > The AMD CPM6 PCIe controller is based on the Synopsys DesignWare PCIe
> > > IP and integrates two PCIe host controller instances. Add the
> > > "amd,versal2-cpm6-host" and "amd,versal2-cpm6-host1" compatible strings
> > > to describe the HOST0 and HOST1 controller instances.
> >
> > That is clear from the diff. What's not clear in this patch, and I
> > probably already asked, what is the difference between host0 and host1?
> > Usually instances are not different compatibles...
> >
> 
> Thanks for reviewing, there is no functional difference between HOST0 and
> HOST1. They are two instances of the same CPM6 PCIe controller and support
> the same feature set.
> 
> The underlying hardware and driver behavior are identical between the
> two instances. The only differences are instance-specific resources,
> such as register regions and controller-specific interrupt status bits.

The only difference I see in the driver is:

+/* MERGED input bits for the MISC_EVENT sources this driver handles. */
+#define AMD_CPM6_MERGED_MISC_EVENT_HOST0	14
+#define AMD_CPM6_MERGED_MISC_EVENT_HOST1	17

If that is the only difference, I would make this a property instead.

But there's another problem here:

+		/*
+		 * CPM6 moves the per-controller MISC_EVENT registers
+		 * into a separate "intr" region. The SLCR block, which holds
+		 * the shared MERGED/PS_MISC aggregators, is shared by both CPM6
+		 * host controllers, so map it without requesting exclusive
+		 * ownership; otherwise the second controller fails to probe.
+		 */

This implies the 'slcr' region is the same address for both controllers? 
That's a problem because the DT should not contain the same address in 
multiple nodes. There should be a single 'slcr' node.

> I understand your point that instances are typically not represented by
> different compatible strings. Given that the driver needs to distinguish
> between the two controller instances for these instance-specific
> resources, could you please suggest the preferred DT representation for
> this case?

The answer depends on what the variation is, so the patch needs to 
explain that.

Rob
