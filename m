Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B903C3F4A;
	Thu, 13 Aug 2026 06:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786603012; cv=none; b=epfL1+IeCgyPPJKJ61tnZhQjQ01fzpESf7QeEb9LR9sdf3ogXP3GAGTq5M1eYVS4Ap3Yk5S1aU4qF8tgsy1IxdAmuagg3qYvzppm3Kv6f9I8opT0BWM3IydN3VhKunBHLyVZBk86JRdTkhTxIQqOUq6WycVKeTOTc4flHAl/dJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786603012; c=relaxed/simple;
	bh=1WC2yiJFynf3OXJX0Ltglag6zYDsA6iJLgU27QeXVhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IAmWmsdFL4nRvdaq2jOipuln7isEXIe3dUxBNSK4NF2Uj0T/PxnaMcqWkueOe0EpZeQYJ4HVvi7ahstfgux5Nd+BM7AiaX13YtuigFrN8XD4qH0ARgMAGXbPUomEYgOqvk95hfyAKadAqoqiG43Em4qPyuTulQRyLtwEnE+dOWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kXCfK3gJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kXCfK3gJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A85981F000E9;
	Thu, 13 Aug 2026 06:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786603011;
	bh=cTYUQK8uwLBOSJl0Vd/0vpmuNbAw3wbk4WjrMQwfYWA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kXCfK3gJ0M2spnfT9LmKSPYACQGbfk3LjYg2tY0d9gmn75TxfEmWWHmGp7ru9RMec
	 adM0l4oq+qQQVGltXmVz/QFWTFZ4lAkXNpXsywP0KQj/X7gdKwqosztbZdIxwIOPM8
	 2DPKrQZkfOvvO+IWA6CGkzRD8bczFV21AxcStP+i1ESlyXg6/u2UvaF4BMmdPMAJf3
	 BxZ/t31Ib8wnD9UxXyd4vF1bf937cC5LnZ0LAcekZXRGquECNLFJSCpd2waMm9RGOH
	 qDcFHtJ+1k0lAMQjr9V62fdQds90f/jbWU+/wgM0RYKuftoPNthBkmpSXiOt5lBu/0
	 XvwY0+NG/65Eg==
Date: Thu, 13 Aug 2026 08:36:43 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-pci@vger.kernel.org, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	"moderated list:BROADCOM IPROC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv2] PCI: iproc: platform: use device functions instead of
 OF.
Message-ID: <iumbya4k72oug2ze3cwhv4ibznsqsd6mawh4dmcvxuia3p5vs5@mbugjn7x4otc>
References: <20260727234408.296186-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260727234408.296186-1-rosenp@gmail.com>

On Mon, Jul 27, 2026 at 04:44:08PM -0700, Rosen Penev wrote:
> Since this is supposed to be the higher layer file, use higher layer
> than OF to handle this. Remove OF headers as a result.
> 

What do you mean by 'higher layer'? This is a OF only driver. So what's the
point in switching to generic APIs? Please stop doing these not-so-useful
conversions.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
