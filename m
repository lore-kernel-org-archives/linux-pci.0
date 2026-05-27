Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31BAC3DE44F;
	Wed, 27 May 2026 08:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779870476; cv=none; b=kIRGrkG1qSC+SObVQy+EIs298q3ULe/1xqiBav3ncRm7wKGOr9LEV/8hckgWkDu/XnujJIO3/SS3/sxyCi8QVoRysZHt6x6CFHY9/JO1k476xu27XqXj2urJrtPHpyVKwSLCDqrzeGPdz+CkaaB6iqUYP+zqKeVGoVppvU7L97E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779870476; c=relaxed/simple;
	bh=0EU+idclOPI1x0bFan4HxVdIaHRb379YphL+SiiKxAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d95s9/DqA723Fet9hO7KjtWY2OZ971aYBbKUflg36uI+yTTma+TjWclGAy+vZWe9m/RwK+NNjeYRK9KxaBkCUfKiJo/lkcYDjV4as57p+dT3GciK0JCBFKV1szdTLNHFNGkmoF0JLynBTMVFdzZM4pzsVugx1VoAaJMGWQmOxMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QbgSW71j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QbgSW71j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 729981F000E9;
	Wed, 27 May 2026 08:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779870474;
	bh=5hc+k9LHeITSB6OaGd6jF7VjQHEB3e/mw9hpgzRqNP4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QbgSW71jV2EAPPMRNE5AygyC44KzqyImSEgPmL4XE373ZqMYvDlMpbkcL3wqtS7RT
	 runcpL62Ct/m+Zj/bSXZjzxB2TFQdOYIBN5XDv96q+17qazro/e12aR3zci6orT9ks
	 ITkF6qEUxc+UWIcQwlvdN8YVryKcUfzV7kvL/rVp66A4uT1pB0Z8CpPkKBF6L+cSs3
	 +/zv78aAlzh2JDMHpYJgorbAf8FTwb8CBvn8R3NkYCwMh+aCi0SYhSl6gus0KDjsP8
	 xAiUiZQOag79pwfCwaimnRdU3r6VncEuJSCFtiau5PHpYV1d8nsr5AqEmJvUo3JTlU
	 Kri/o5JKVJ/cA==
Date: Wed, 27 May 2026 17:27:52 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: mani@kernel.org, kishon@kernel.org, bhelgaas@google.com, 
	jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com, ntb@lists.linux.dev, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, den@valinux.co.jp, 
	Frank.li@nxp.com
Subject: Re: [PATCH 0/2] PCI: endpoint: pci-epf-{v}ntb: A couple of fixes
Message-ID: <20260527082653.GA2120839@rocinante>
References: <20260407124421.282766-1-mani@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260407124421.282766-1-mani@kernel.org>

Hello,

> These two fixes are flagged by Sashiko during the review of doorbell series:
> https://sashiko.dev/#/patchset/20260406155717.880246-1-den%40valinux.co.jp
> 
> Manivannan Sadhasivam (2):
>   PCI: endpoint: pci-epf-vntb: Add check to detect 'db_count' value of 0
>   PCI: endpoint: pci-epf-ntb: Add check to detect 'db_count' value of 0

Looks good!  Nice clean-up.

For the entire series:

	Reviewed-by: Krzysztof Wilczyński <kwilczynski@kernel.org>

Also, apologies for being late here...

Thank you!

	Krzysztof
