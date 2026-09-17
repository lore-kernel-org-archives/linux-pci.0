Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8094A3DB62F;
	Thu, 17 Sep 2026 19:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789673118; cv=none; b=aaAhVfy3hUjxP7Jlf084+yENGNXmtbZdHuc4lde/ZGfPwr3CQS6rd8Y9PY+lCMncnO5ARxkODdVQB+bje0kgeC99jzro5ysdZ45bu6/Dxnr845Wynel4lVhFq6Nc2yiFLUKWYiFqlnDLzoXNEWhnn8sHRR/nCTuek8vHooQKK/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789673118; c=relaxed/simple;
	bh=Rub1p1ej2uqP0hTHr9T2J4RRTKOfNI89iHv3I9XKy8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U8tcKHnFo0lj2G/RKMcZciYOAWS5TnOmY0lL6prImCbqwj12hdaimb9tKWzn2ciZIGW1svtqu68aKutP/xwArqrg/u+FonGPmmsEKUsWrAHUUTk9mQr009JsEJ67qkK+PG/xFRhGfNW5psrwitRAcoEvnehu7Pxop9NoqIdqCE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PHxlFK0f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PHxlFK0f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC5031F000FF;
	Thu, 17 Sep 2026 19:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789673117;
	bh=z+UrWXf+3mraC1/xhx95xER8J1cuQI2htGiyOXiHHoA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PHxlFK0faV7Q3LQlRvy6Z0MRHy0odulVzp5hiygHGftXQTCr0uFVnQFexxVP7KseX
	 6Czz/9ro+wrQm/3P5ddzV8WmUR8zTqR69AoiRdpwKldFwkijUdj+WAdRX+q/mpTkQg
	 ZhnGo5MXwbq7TSOZUEXIUhoMivCehYhkox2A9qnHMv1tJNQkzASnGuPTtyBZ80YnQp
	 hbvr93rwMBUpaMqKcyhC6boLnoGrA752RtdJsBjL8/gDCAOp2nCzesPQ4YMCmCjIbM
	 3LsaHr2XbIJ9FmeBWYVWzT7Hqk0gLC1mK1RUbt354OeZhVT42ks8/cxp57KsyzZ8N4
	 tXZDfiIUS4DwA==
Date: Thu, 17 Sep 2026 14:25:15 -0500
From: Rob Herring <robh@kernel.org>
To: Sai Krishna Musham <sai.krishna.musham@amd.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
	mani@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	cassel@kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	michal.simek@amd.com, bharat.kumar.gogada@amd.com,
	thippeswamy.havalige@amd.com, pranav.sanwal@amd.com
Subject: Re: [PATCH v7 1/2] dt-bindings: PCI: amd-mdb: Add CPM6 support
Message-ID: <20260917192515.GA3283677-robh@kernel.org>
References: <20260823040715.204096-1-sai.krishna.musham@amd.com>
 <20260823040715.204096-2-sai.krishna.musham@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260823040715.204096-2-sai.krishna.musham@amd.com>

On Sun, Aug 23, 2026 at 09:37:14AM +0530, Sai Krishna Musham wrote:
> The AMD CPM6 PCIe controller is based on the Synopsys DesignWare PCIe
> IP and integrates two PCIe host controller instances. Add the
> "amd,versal2-cpm6-host" and "amd,versal2-cpm6-host1" compatible strings
> to describe the HOST0 and HOST1 controller instances.

That is clear from the diff. What's not clear in this patch, and I 
probably already asked, what is the difference between host0 and host1? 
Usually instances are not different compatibles...

Rob
