Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8225618BC3D;
	Fri,  7 Aug 2026 05:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786079317; cv=none; b=jvmnEyHX6sBMG0Q9k9643QbJe8pabB20jWisU2eOytaqIg4Pz8DesP5B+CRTeZntlkUepyf3W/7f3jyAmtK3zJtxHetRkbEu8n/8jJn5luKDty7SJr1bsH9zjHPT1ehjQBOADPhC22JWSctBOqwoomfDMg1o/LEn0UqBQhYYkVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786079317; c=relaxed/simple;
	bh=fgPl6HBIMo0mSi85UMz5zNEOPawNow5M4mV3hkhFG14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a103UQ+0ICwm6Uycq20gVRx0VzfsGUDFRx+UGBrDNy1gbTbaj6n7MjqJhOzX6z9fm55+rjVJSeFep4agNFBOYxFC4N4iSI5QFMMbvwqqNRfG0shxNeUVVbT3bNJT6ts+Td7TGrGCmvUkJMsf106TylgE9BoBe8wgbxncfQasSqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a/8DxgPf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a/8DxgPf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E15BD1F000E9;
	Fri,  7 Aug 2026 05:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786079308;
	bh=Tvvj3pvuSeDsq0S3Dz0sOIlBP6v7pEFsuALYAPfUJ0k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=a/8DxgPfLBo7vzR5HWIqG2LH/jbKvVYjrUChwaYjExIymeZwKVTuobKEJXyeHAvo0
	 hhUXvIfsQy5h9ee+l+iC8JHGAkQeP2C5wv2OUtRV23dIf9fbhVGkgnXwnVz4D94RH8
	 zk5MiXrmrpp3adSOi8jgE5QklkFsbR979W/jUCE0Ht823OJ7PII/TonDcwUP2V81AA
	 MRXfuqj5X/ccILvRffcBXQyevEX9kP2N/xDqRrcmRkFn0qjPAp23Qm6kWMQS+ZOgbY
	 eV9A/YFBrSIOnHeuOqD60WVH1mTPkchQRx2dDdfp/6Q/pgrQid5Q/5arn8fkR+ANy2
	 6OHku+vcD8Tqw==
Date: Fri, 7 Aug 2026 07:08:10 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Szymon Durawa <szymon.durawa@linux.intel.com>
Cc: bhelgaas@google.com, nirmal.patel@linux.intel.com, djbw@kernel.org, 
	linux-pci@vger.kernel.org, Lukas Wunner <lukas@wunner.de>, 
	Jonathan Derrick <jonathan.derrick@linux.dev>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: vmd: Add VMD Device ID Support for Intel Nova
 Lake (NVL) and Dunlow (DNL)
Message-ID: <5x766agwcab4fshoel2zejl4jqoucrflaudsd27fqzfebamvsn@vflqqv62ldb7>
References: <20260729175320.1400987-1-szymon.durawa@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260729175320.1400987-1-szymon.durawa@linux.intel.com>

On Wed, Jul 29, 2026 at 05:52:55PM +0000, Szymon Durawa wrote:

Missing patch description :(

- Mani

-- 
மணிவண்ணன் சதாசிவம்
