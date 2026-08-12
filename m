Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594821E5207;
	Wed, 12 Aug 2026 22:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786573949; cv=none; b=hlFwvF95EYpgnmxT9FuNgZKqGjnq4zhAYAfsDIAsheuyQe/AvF4lLEW4F0Q4hKLbtFXsVIgKa4uR25uOPZsL6VfMD8CzUwViRPrn7rOVC1i8qrbsIcM+rjUkjIrm3oHZKjCWsDgrq2vBqE69/OxKHKMbHIrP9y/+l/indTK4YBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786573949; c=relaxed/simple;
	bh=O+l0HXLZlL+IXBxuaZKr91BCwXM359QphHlNRvZ8aSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AG6vqQu+lkiclNkiiBWpu5HeJxd0+ImgG8fNFOB7Q4JtB+2Sc5fri0DYw1zYYDICOg4C1CArr55+Y75tcLLMPxAxL60N5we2pB3XTkIOWG5t1jYETm2NZY6GT/DynUFchVdIHWyzLwOO3jtxt3WVfp3c0sQYdNf01WQKiYsbvR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NB7cBTAY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NB7cBTAY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CACED1F000E9;
	Wed, 12 Aug 2026 22:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786573948;
	bh=9D5LiynZySzDaGZqy2wClbr4/g9gh10IDgkh0E5wuNM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NB7cBTAYE5HA5aQKflu8mNd191iw5eSOd+k/sBZvz3oSwmq9c5+0BQuPYvRLhG/va
	 MexZUcuPW1ANn9qzjeDGTBC6r5eJHaCO0LvJ98o8prwQgBrMHVRD/cZ6eChwwTuH1D
	 lJsZgaF0YYULKYDMcaYDf2lGaS47tVNARlYiFrKePjLcnA4Az0cfb+QgXa2Hs7S6RE
	 LkcQw7zFmn+AMhlSyAc95HWV6PCNFDpr7XHdat7NeSdTtWNoCskNVbAyvd3xYeTMwE
	 HkHFUsczvE9G6hreF9CVrGBWYtYTr8otFDuvZslrRmYyU8kLKwzHkky16pFq9Y6vyn
	 UEbus/8zR0gWQ==
Date: Wed, 12 Aug 2026 17:32:27 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Sai Krishna Musham <sai.krishna.musham@amd.com>
Cc: lpieralisi@kernel.org, michal.simek@amd.com, mani@kernel.org,
	bharat.kumar.gogada@amd.com, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, cassel@kernel.org, bhelgaas@google.com,
	kw@linux.com, thippeswamy.havalige@amd.com, conor+dt@kernel.org,
	krzk+dt@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 1/2] dt-bindings: PCI: xilinx-versal-cpm: Add PERST#
 and reset support
Message-ID: <178657394651.1335393.18337349834069898835.robh@kernel.org>
References: <20260807140205.1070367-1-sai.krishna.musham@amd.com>
 <20260807140205.1070367-2-sai.krishna.musham@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260807140205.1070367-2-sai.krishna.musham@amd.com>


On Fri, 07 Aug 2026 19:32:04 +0530, Sai Krishna Musham wrote:
> Add the optional 'resets' property to manage the PCIe IP reset, and the
> 'reset-gpios' property on the Root Port child node for GPIO-based control
> of the PCIe RP PERST# signal (assert/deassert). Both are optional to keep
> backward compatibility with existing device trees.
> 
> Update the examples to show the reset controller and PERST# GPIO wiring.
> 
> Signed-off-by: Sai Krishna Musham <sai.krishna.musham@amd.com>
> ---
> Changes in v9:
> - None
> 
> Changes in v8:
> - Add resets property.
> - Move reset-gpios property to child node and update the example.
> 
> v1: https://lore.kernel.org/all/20250224063046.1438006-2-sai.krishna.musham@amd.com/
> v2: https://lore.kernel.org/all/20250226124358.88227-2-sai.krishna.musham@amd.com/
> v3: https://lore.kernel.org/all/20250227042454.907182-2-sai.krishna.musham@amd.com/
> v4: https://lore.kernel.org/all/20250318092648.2298280-2-sai.krishna.musham@amd.com/
> v5: https://lore.kernel.org/all/20250321114211.2185782-2-sai.krishna.musham@amd.com/
> v6: https://lore.kernel.org/all/20250326022811.3090688-2-sai.krishna.musham@amd.com/
> v7: https://lore.kernel.org/all/20250414032304.862779-2-sai.krishna.musham@amd.com/
> v8: https://lore.kernel.org/all/20260807123507.3418671-2-sai.krishna.musham@amd.com/
> ---
>  .../bindings/pci/xilinx-versal-cpm.yaml       | 38 +++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

