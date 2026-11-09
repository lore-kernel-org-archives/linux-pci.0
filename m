Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794229678;
	b=mA2JCQTQrVIYa+jvwG/9EnCMr7somvrstCc+ivy5NgRw6CjxzpAXin1NVZ4ahqfRVLhF
	 idAmvM5ft4IY4NfbCI+DN5sIUhEK6M/YpzajkDQe3UcdGJ7k7P2cFVcjlfRDxsVasZxa8
	 MhsgkVaF8oqH5sua8ebB8REunEfU8ekNgW5tbkV0f29EHiB0aUdsxBjde8KalTtfyhxrS
	 IQy0olE3oBHZzfS6TrFnl8cCXvDcgUwy5nJ8CkrB04yD9x2LHQkuHDbLxJnb97crJHsYs
	 CJDz2pYLjZAIf+J1rrqcCBU2XCkK9g9B6ezQSiecaa7eHfRE6dOorYeByGzUquWSZIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794229678;
	h=Received:DKIM-Signature:Mime-Version:Content-Transfer-Encoding:
	 Content-Type:Date:Message-Id:Subject:Cc:To:From:References:
	 In-Reply-To;
	bh=6EqaVezyVPtXvMeQC6ap3fEShaooSz1/C+wEJuwQn0Y=;
	b=iIVBrfyvm+YZs0nEMCfu7Kyap9VlnaKaixa01Se9nltPEplLiWpaW2aGVNbOSHthFvKX
	 Dy8/X+Wnsar/5xe0Tgm4NW1+GawShSQcCpXxGkoR3dHfdMdycEdh/Md9wdtj0u7jMbjud
	 ZshyNNvPbR8KO9LjN58VzTGazaKkuFfBKRA9Hnj/v0YhuXOLYX1mvMKUt6CzYCa9bdl6Z
	 ZLXEXm6IK9dk3opQ0hRxkBgyyJS2FFiaF2Qa/U8/QPbrJRJSTOGw/SaOqHY1GXTrAB6MW
	 JdpcT/g/wfIGyiT6nZr+kSRdJ6vPZtkBbwd/G935XVVJlnxfHQ2tI0S+w+HBFVM//Ag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N6zrtbC1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78EA7606A33B;
	Mon,  9 Nov 2026 13:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N6zrtbC1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE6F21F0089F;
	Mon,  9 Nov 2026 13:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794229678;
	bh=6EqaVezyVPtXvMeQC6ap3fEShaooSz1/C+wEJuwQn0Y=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To;
	b=N6zrtbC1rX7wVQPI4Te1xgV92K6rFOhSt4qjXWKvCQa47vcGGxJFUEi9BP0hMZd3L
	 0jFWiF/OlRb0WYNb0Ytek6HndakXsYE1cjzzKbBWoIEqOB57fvVwXBuzCt9cDPgpjT
	 yy77EyQVx1zNl0aqxFAzYAkVOc/UfEb2AGb5MZeOtm0Gv6kmrSACSmL0qgatnEhPfR
	 8J9dOwDNVHHp3kH8p/HwsIZB+6cTtiTwS/H/KsF6xs/waR+7VQsyeLGFOCutVQH4Xe
	 wt+TqhSeSAo6uWhHacDWircctvmHZgDkCIdvpxDTJWG7wM42b4r2WulvbhzA0gSc4/
	 yOeCFdn6IHIQg==
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 09 Nov 2026 14:07:48 +0100
Message-Id: <DMQPC2HXYEZF.2NIJVLP4URRA9@kernel.org>
Subject: Re: [PATCH v5 7/9] rust: pci: add SR-IOV enable and disable tokens
Cc: "Simon Song" <xinmengs@nvidia.com>, <kvm@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <linux-pci@vger.kernel.org>, <alex@shazbot.org>, <jgg@nvidia.com>,
 <yishaih@nvidia.com>, <skolothumtho@nvidia.com>, <kevin.tian@intel.com>,
 <airlied@gmail.com>, <simona@ffwll.ch>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <aliceryhl@google.com>, <tmgross@umich.edu>, <markus.probst@posteo.de>,
 <jhubbard@nvidia.com>, <apopple@nvidia.com>, <joelagnelf@nvidia.com>,
 <ecourtney@nvidia.com>, <cjia@nvidia.com>, <smitra@nvidia.com>,
 <kjaju@nvidia.com>, <alkumar@nvidia.com>, <ankita@nvidia.com>,
 <aniketa@nvidia.com>, <kwankhede@nvidia.com>, <targupta@nvidia.com>,
 <linux-kernel@vger.kernel.org>, <zhiwang@kernel.org>, <zhiw@nvidia.com>,
 <boqun@kernel.org>, <daniel.almeida@collabora.com>, <tamird@kernel.org>,
 <work@onurozkan.dev>, <jgg@ziepe.ca>, <bhelgaas@google.com>,
 <kwilczynski@kernel.org>, <dri-devel@lists.freedesktop.org>,
 <peter@colberg.org>
To: "Alexandre Courbot" <acourbot@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20261030171230.196717-1-xinmengs@nvidia.com>
 <20261030171230.196717-8-xinmengs@nvidia.com>
 <DMQNRGDHAK0A.3EZQZGAHKYF47@nvidia.com>
In-Reply-To: <DMQNRGDHAK0A.3EZQZGAHKYF47@nvidia.com>

On Mon Nov 9, 2026 at 12:53 PM CET, Alexandre Courbot wrote:
> Do we want to return the token back in case of error, so the caller may
> try again?

I'd leave it as is for now, I'm not aware of a failure reason that warrents=
 a
retry and I haven't seen any of the existing drivers needing that.
