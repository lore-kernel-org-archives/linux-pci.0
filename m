Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4799B1A9FA8;
	Thu,  9 Jul 2026 22:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783636929; cv=none; b=Sb88Nlcj2ARHjUYgNevhyN3KwNgNjwmZWSPVNrXUy44vHV58aqiNxqYoG14HHxCEhMwWHC/ExvPs5xOC5JTyKY1s2KO51S4dzDJ2j0G1t5zFmIKwQYszDZv0vK+PjrOnjejke6UPH1Me7MKHVB+820acuWgeoYlk1IUlWuty5LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783636929; c=relaxed/simple;
	bh=wwOiS1jTfv0k2cDudKThF1veiYSwYrxs8097wzSvwCE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=qATJzoBmLu3c3FTOavKyaxAbn70cRwtdmP1gRCEbDVIFT6AHOecTnZC45juj2UsxOPtX49SWOb2VqmujYeSmVu317Qx2V3odaz3k3Wba/k9Rmg+rM21H+SVBTd5ae0sOJYf0RSmw/f7IsXHGHXhJm2i9PSUzoN05LKp2/x8mr2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ifBPq5OZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ifBPq5OZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B59D31F000E9;
	Thu,  9 Jul 2026 22:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783636927;
	bh=kZqBV0h2Ysco3x+okR7LyFcVjz1JoLkubJmF60s4PQE=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=ifBPq5OZNsfvHF4IGu8LuJGf83QUd79cM+cHTY1CR8Batd5orrPwwwF192hm8OKYd
	 mxS+g9rw5lKu1fwymJvdYXcpS0GJZtCUTIsa90eKNL6yhKyeG7IUbYyUgYsBCQa4Q8
	 RiMZM3j79jIPsd1tShNZnh6bk39zsjzNIFKQRSI4i0b10/rigC/GgUoYdEr1waLIwg
	 310VZDFIzWu/ML0A0K9i1SO2wDqQKO04VY7I8lFkM0XHE+uEXmMeAwQbM4pQr0qn7h
	 PcPOtcSFV0xN9v/Nzi3T8ucFtkNPxsc0YPsxXLIr7qPxx9nItyfpLpCCimXOdKkNIh
	 O9b2sLNqsJbwQ==
Date: Thu, 9 Jul 2026 17:42:06 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Yury Murashka <yurypm@arista.com>
Cc: bhelgaas@google.com, corbet@lwn.net, skhan@linuxfoundation.org,
	mahesh@linux.ibm.com, oohall@gmail.com, linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 0/2] PCI: Add boot options to disable DPC and AER
 recovery
Message-ID: <20260709224206.GA913007@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709185429.627968-1-yurypm@arista.com>

On Thu, Jul 09, 2026 at 06:54:27PM +0000, Yury Murashka wrote:
> On large modular systems with a complex PCIe tree, the default kernel
> AER recovery and DPC behavior could cause unexpected side effects.

I can't tell what the actual issues are, but if there are kernel
defects in this area, we should fix them.  If this is to work around
platform defects, maybe we need quirks to work around them
automatically?
