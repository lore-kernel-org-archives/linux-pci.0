Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECEF04A093D;
	Thu, 10 Sep 2026 14:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789052030; cv=none; b=X8q+X/5mMpwPqMJbGG/F5Gd1E/B1IgLqPMF23hGMFNzWPTiAMunH4AHAZQy+2w9Un+ArgdOKh6G3txF97JqhTqUApOWl0zpqJMtLHS3r130TVPMVhy4HXV9GgWs0Ft7Lt9ynK+GHLZUKQPZROWqnnMwa/OWQUaTGcDn+dbKO23c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789052030; c=relaxed/simple;
	bh=ssCXzE11ajp+z1FBNj6xKfgqzRH3MOsGJ1EdUKx0RN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OhavQd/XZ/S5XweSjz6q8W7ZSSjmyolx8I7CypdJdB69D6OgH/am/e96uDHEzAz3zda3uzkcfhxRnBqrKcT3a8pgwvdZ3NgbKvuHHHS30FRPSwMlnfOiIsbtRWeBGETudTL4v6Lcj9/VpwLll8pBXkxmHsnA9EBfxvlRQyboOtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i2JoBAH/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i2JoBAH/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BDBC1F000FF;
	Thu, 10 Sep 2026 14:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789052028;
	bh=9OPS+xkkQJCElwq/tseCCeVoLqNSDE7wwyxeZzZI1W8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=i2JoBAH/bvA29K5SXu1CjD1hqwWJEjJolJvSRgvAVXbMcdsQSeiWiIaRil2Z6cVH4
	 ADsDUkmxjVJ8M4Ujr3YSbRv+E0vGEs5QRM7JaRl9vCTXRiEbeg6fz2v8yUVC+RN2bl
	 PFyv3zElqrOEpd7qlYjkrNqgRXyubKrNqqJLNzpUBe8Z4lOOoi8aU+3/VZkd8FCuAm
	 2xF6SxjSE+k+qA2Oz981NhhOa7Nc0eXe86YNEDM60xMBYRcrN/fL/anCN+eboqcDUt
	 iuR5QhIbYtkxVebTjUFwnEiazuE+GFMo7I8wBy9sG4cbtR6tuYv4o/DWGe8lsJ5e38
	 i8UymBZp3G6dw==
Date: Thu, 10 Sep 2026 16:53:38 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, Bartosz Golaszewski <brgl@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 1/5] dt-bindings: phy: sc8280xp-qmp-pcie: Document
 Shikra PCIe phy
Message-ID: <luuofaxoe262a2osrs6aev7fpmufkscttjkt7jaw6litrapcgu@rhowfgx7mymc>
References: <20260831-shikra-upstream-v2-0-406661d75afa@oss.qualcomm.com>
 <20260831-shikra-upstream-v2-1-406661d75afa@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260831-shikra-upstream-v2-1-406661d75afa@oss.qualcomm.com>

On Mon, Aug 31, 2026 at 12:56:01PM +0530, Sushrut Shree Trivedi wrote:
> Document the compatible of the Shikra PCIe phy which supports
> Gen2x1.
> 
> Signed-off-by: Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>

Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

- Mani

-- 
மணிவண்ணன் சதாசிவம்
