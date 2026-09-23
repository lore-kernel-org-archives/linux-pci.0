Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707C3490BEC;
	Wed, 23 Sep 2026 20:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790193778; cv=none; b=RnbKruKZ+1lWWzS2swT07g15xVnpUnhKgDbzsBDe91bekvnkxg4nyH54PgTUJ0IlZhjardRah2L8HfETKzY6tuWAQVe6obSlQVYpFchm7D21sDygZ/Hdxil9o0TJZPdbR0e4Ymj50EqqSyYSxGDP0UgenT3DLbT5axqkYim7gp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790193778; c=relaxed/simple;
	bh=TlDLmq0JR56TfxUVJzUoIlyOGjfO3L6JzjvSRWosYfU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=IvSo1Lo8pqDx7MdAt31qC2p+GGYXu3dKuXW+RGvTANXqXse9l5xkc1CkSoUGKVRXeyq7IAx7LKlrzPer5apQ8S8viQUeNLg8OttTxKV3aIl0W8+pq5tiphHifLw66iixbW4v0Xw5YJseFldhBNRzQOmY4yDEGxHjtKXSXlpeDF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eL5P2x4j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eL5P2x4j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD1B41F000FF;
	Wed, 23 Sep 2026 20:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790193777;
	bh=Nso/e5NC6vGHJJOSEX1whmEtIbmD1haWAw8B0rngw7k=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=eL5P2x4j513DV9JQjbAW8ljFQFe2pyyqovOQjdQ1BFsaAPkJtsHi5CBFqqT3/J3IU
	 L3hAoQ2x4R32TuidCzWkpqw8HnjFXRyi1VBafUbS5SSEJ3qwJL5KbESeZner8KVbof
	 2uNm807JTYc3RvePthVmJE2rktoltMQeYchzsS9AYcMZYpmAYAAW90mb+igNOs6fNJ
	 TkyB4auZD0wblBvYyPQ6XXvbny+E6xhu7ry8yXzdotumaSn31X3YsItk6vjDPGEJyB
	 6D5Oy/WbCi/nHG3hjf+l3HrsGVOo5zcpK3HFl+LmRwVdeonz3xS15fBVkOmxCg4va8
	 OdZ8e1TIbT4Jg==
Date: Wed, 23 Sep 2026 15:02:55 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alex Elder <elder@riscstar.com>
Cc: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Michael Walle <mwalle@kernel.org>,
	Daniel Thompson <daniel@riscstar.com>,
	Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Subject: Re: [PATCH v5 2/5] gpio: tc9563: Add support for the embedded GPIO
 controller
Message-ID: <20260923200255.GA1934030@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea49aa8c-af1d-445d-b15b-25079cdcc72f@riscstar.com>

On Wed, Sep 23, 2026 at 01:59:49PM -0500, Alex Elder wrote:
> On 9/23/26 1:52 PM, Bjorn Helgaas wrote:
> > Patch [1/5] and a comment below mention 37 GPIOs, this mentions 35.
> > Are they supposed to match?  Maybe 35 doesn't include the two reserved
> > ones?
> 
> They are numbered 0..36, and two of them (20 and 21) are reserved.

That's what I suspected.  Any suggestions for rewording this to remove
the ambiguity?  The current "providing 37 GPIO lines" and "implements
35 GPIOs" just raises the question.

> Of those, 10 (numbers 0-6, 12, 35, and 36) exposed outside the
> TC9564 chip itself.
