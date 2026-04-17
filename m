Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E96B3750AC;
	Fri, 17 Apr 2026 10:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776422920; cv=none; b=f2qxKiZcPOweLEAaVZS0IAlsScM7FvZ/TppTThQ7XT7HFkQ/gH7mf/Sp+O7TT9RsQdAJY87XdTgePTkK0JkgewCwD3tjKcaaBoQwg8cSVjSv3WfsT03pzXRMQCvvjrpP3LbdSqAakUoT/2Rr8oEgodjEaFgKtsSYk928n392q4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776422920; c=relaxed/simple;
	bh=NZ4L5TbaryQyemnvmTo0G7UCfCM0zTYTfU0gMp+J5zY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MClP0ShdRXbkJp8FClCOZNydGaTS7bVCohzowdW/L8evRJIij3rheFyh4d26Q3S/i3tG6f0HxOae0KlpIRK+wmp/ws/P1tfGb1LQcYpWPm/5TAtFMgLV+arc+9suVxr0bLhn8lzhS0fGn+kkGfMTHtXHKYTeeVlDmdMWz3T8hUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V1BOBzqu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V1BOBzqu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE93CC19425;
	Fri, 17 Apr 2026 10:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776422920;
	bh=NZ4L5TbaryQyemnvmTo0G7UCfCM0zTYTfU0gMp+J5zY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V1BOBzquaNxV3WPHm/o4jp4vDitleIK+cdy0/Bx5aIGXy3iKZsLYRTF883ul1SQ3h
	 v4Co5SpnbaEGEs0dad17Pc7L74SMR8QB6wdqBPcaE3ySu/WWplvgctNaDsDmoWBPdg
	 RRrDN6lPu05Kub391Mr1YIP6vBFrbaGofifgVoesvdYpwYSpTP0kaOXcHRB4NdmP10
	 l5B4U1luxObFMziVO9xXlDFWx8m/vQj2T9VsbjKmtHCEFEJk9qLvzxhTcA7GsND3F4
	 TKmet+i/EWVu5+glrHgNMvgvIi0iTyWNPns6RzIjFa1F6h179mRpssDGjrpIBtp7Qr
	 lF67Bv4Q2INcg==
Date: Fri, 17 Apr 2026 19:48:38 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Bjorn Helgaas <helgaas@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Magnus Lindholm <linmag7@gmail.com>,
	Matt Turner <mattst88@gmail.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Christophe Leroy <chleroy@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Dexuan Cui <decui@microsoft.com>,
	Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>,
	Lukas Wunner <lukas@wunner.de>,
	Oliver O'Halloran <oohall@gmail.com>,
	Saurabh Singh Sengar <ssengar@microsoft.com>,
	Shuan He <heshuan@bytedance.com>,
	Srivatsa Bhat <srivatsabhat@microsoft.com>,
	linux-pci@vger.kernel.org, linux-alpha@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v4 12/24] alpha/PCI: Use BAR index in sysfs attr->private
 instead of resource pointer
Message-ID: <20260417104838.GC1625998@rocinante>
References: <20260411080148.471335-1-kwilczynski@kernel.org>
 <20260411080148.471335-13-kwilczynski@kernel.org>
 <36cdf28b-281f-46c7-d4b5-083675b61660@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <36cdf28b-281f-46c7-d4b5-083675b61660@linux.intel.com>

Hello,

> > While at it, add parentheses around the bitwise flag test in
> > pci_mmap_resource() to make the precedence explicit, and to
> > match the preferred style.
> 
> Probably not necessary to touch this line now at all as you're going to 
> replace it two patches later anyway so it just adds noise.
> 
> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Makes sense.  Taken care of this in v5.

Thank you!

	Krzysztof
