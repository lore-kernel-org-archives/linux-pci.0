Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F09326D4A;
	Tue, 14 Jul 2026 17:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784051691; cv=none; b=F0JQV6skdrIZ3rNEGEy7GV/qE+BJgFJLWFFlsWLFsJLSMsFUtL226YbfSx70txECK5wkHPj/y/8onaliNpN0xDhLrFlujHslf6HWa7RnKnEAhPgYDmzKD8wtQS5hdfvSf6fgCxqOlBi5L/HKA9ivOtZAw8qL9XmjGFNx6oSXS1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784051691; c=relaxed/simple;
	bh=Cpy8KufM9+q149qXSXukxQuOIDy8E/0chpj5fsC1+Pw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=jyp8GZmDUWwknupKLG8837rttul8zwRIIs7QHe59+xnsxoRVZ9TNd7LJQnW+3mYWm/4vhp4rExMTvqDOBPoYdkRf3o+tGULsDxZ2zE9G5mEa42d90BTsOeD8u7oY6BX6z/1TcTWspUuPm4yz50O+jyFSo+3biiUx22ffhR09hLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LzysDW0c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LzysDW0c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A62781F00AC4;
	Tue, 14 Jul 2026 17:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784051688;
	bh=XMY557ajVwyQKWaEtMvSy4zYALGsq94ZBPlQ4UdRKHQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=LzysDW0cccHkyNpId7LukWliAMYw5I9nXp1aVed4DeW5L9g/LPB+4io+UnuSQ9crW
	 O9nyhrc9D0cQJ1MQMKjpi3w/+P3MMFW53qxjXq1wQXB/G0H2lz+3pW3V0FNq+wnVj+
	 i6CXOz5oe9Qoeb+OekIfttN0xzK2xTONwne+kmCuGFtkR7e/BEz4Uz0Ww+zqamAjEs
	 mHfhY11T+yO3i1Wy4EaXPAjfo9PXIi1AvW3/FarVDuqLyyyBfvFPhPsHYGPCvzQvSd
	 NKN+DixfMA+whv5mn0uFpHDLgjRx7l70Ua4EMPzMdpfx+KHP1ETOug7DgHy4TMNWUQ
	 GLt2+o0AvOALA==
Date: Tue, 14 Jul 2026 12:54:47 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: D'Orus Tsitera <dorustsitera@gmail.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: ABI: fix typo in sysfs-bus-pci
Message-ID: <20260714175447.GA1382094@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260713-docs-fix-similiar-v1-1-257e25150346@gmail.com>

On Mon, Jul 13, 2026 at 07:14:47PM +0000, D'Orus Tsitera wrote:
> Replace "similiar" with "similar" in
> Documentation/ABI/testing/sysfs-bus-pci.
> 
> Signed-off-by: D'Orus Tsitera <dorustsitera@gmail.com>

Applied to pci/misc for v7.3, thank you!

> ---
>  Documentation/ABI/testing/sysfs-bus-pci | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
> index b767db2c52cb..55ea1db749a1 100644
> --- a/Documentation/ABI/testing/sysfs-bus-pci
> +++ b/Documentation/ABI/testing/sysfs-bus-pci
> @@ -171,7 +171,7 @@ Description:
>  		all devices attached through the subordinate bus of a specific
>  		bridge device, writing 1 to this will try to do it.  This will
>  		affect all devices attached to the system through this bridge
> -		similiar to writing 1 to their individual "reset" file, so use
> +		similar to writing 1 to their individual "reset" file, so use
>  		with caution.
>  
>  What:		/sys/bus/pci/devices/.../vpd
> 
> ---
> base-commit: 0f26556c5eeea62cc934fa8938b148aa5844a6b6
> change-id: 20260713-docs-fix-similiar-b6b96c06f823
> 
> Best regards,
> -- 
> D'Orus Tsitera <dorustsitera@gmail.com>
> 
