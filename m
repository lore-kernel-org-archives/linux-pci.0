Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD67530F549
	for <linux-pci@vger.kernel.org>; Tue, 10 Mar 2026 09:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773136503; cv=none; b=Zr8BzBS+/xy3Fp+PwS5MKM+0PxAWMt0VohVqlb25V8VTALl7fLHDRNwrNyFeO9ZFHSh33Wf0Axz255s/fVU1bMJuvv394vshiZLkSz+eeGE9SJ2HYnv0s9zomYzQpeSb7wLY1xjEzUtsoXLuVPml+mDq7t4TwejQExOPifzJRnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773136503; c=relaxed/simple;
	bh=7cqzu0DYHZviFuOAud8k87g0tOqKObXy2EiltJ+e7Jk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L4wFQ89TLlfmUE98oCpVu+IZJvOJ6dgXHCWGqk+9KJSVyp3PiJZAoKlN24400L0/pz6C9oftGJECK6AYmi8vipsYDz9GW4AJUP46Q6d+MU/sHw81BOcfYzg4ilHf0HWq6dfRzXgsWibml2/rzQuayqQ6HsSIXxUdhQy5Nr6hMws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tmPQRFNI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tmPQRFNI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DD36C19423;
	Tue, 10 Mar 2026 09:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773136503;
	bh=7cqzu0DYHZviFuOAud8k87g0tOqKObXy2EiltJ+e7Jk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tmPQRFNI19rFSYYZ9CoWcpOlyPxVrpS3Ety5cNT5joLfJqv+bpQokFbTiL2YRQp8T
	 /CDZO3/fECDObjSkFq1U3tibOoRdkfqMSHZ0d5eWgwgreMynW7BJ9wTkg/3UbiXrmb
	 EVEM/BF5d9ijaQYmx8BMUDfqweDez8lA9ke3rmyWhX77A491tVLECl6x+FVG3pDokE
	 ySh4a00wYpwTE2wiK/6Rhy7QSemtKqipYiIgddjTOtqSt/3TiyVy7epZQRCuIqdMW7
	 a7iPxSJYn7/Z/fRK5WHQ5zClHMH1lyHCUMLZ9k5x0ZQsMv9abiXFrmU2XJ9joXYGLh
	 mkvr88BRidbZQ==
Date: Tue, 10 Mar 2026 10:54:59 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 0/9] PCI: endpoint: Differentiate between disabled and
 reserved BARs
Message-ID: <aa_qc9v9lLd9MJay@ryzen>
References: <20260302095913.48155-11-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260302095913.48155-11-cassel@kernel.org>

Hello Mani,

Gentle ping on this series.

Considering that there are two other series:
https://lore.kernel.org/linux-pci/20260302071427.534158-1-den@valinux.co.jp/
https://lore.kernel.org/linux-pci/20260303072004.2384079-1-mmaddireddy@nvidia.com/

that have this series as a dependency, I think it would be nice if we
could handle this series, so that the other two series are unblocked.


Kind regards,
Niklas
