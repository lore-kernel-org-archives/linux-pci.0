Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794944778;
	b=BJpnO9YNjrm/Owqta0jM1yh7mE7sVv78uDATh+ZtDIuNOcIO+FXrzFRnIOzdCNNKGvUL
	 DzlKye9KgwgZg1Np+BPy/Wi1h9xYvXCi4GGzZWaxF/n9QTR9U3ftrI3xScX9m79/gAt2n
	 fEmfaGWrN/s2bzpZ3JJPJccFLTKboGHFVvAhYEPrA/bDtOsVflWq/ZEBD3jfyTD3GDgDC
	 pIg42XkqovEN/6f+yI3jRyr8ZXuXKQVBPyIdzGR6xQawc4uLLBWRysKNVaWw3G/XnbDT9
	 Sp3HBsab4v7PS5mQgZD9Ebl784szFJVrDsx2DBjzKW33nj5DDLVuORP9prYozw7sjTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794944778;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:X-Patch-Reply:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=ExUxqEZt6CeU083ngWOHRCSyuGGcbWbRoHP3g8HyKtM=;
	b=aj0Xad4Bl6OL+UYi77Ihuydr9BRB17zDic86nbjunxuQoKruUCe/1wht8BL9rdAtQJw+
	 NlZYVFIJVElMWlmSign8yFMMGoPRp90qL+Lvbb99+u7eyZFEAPZiWY7aUSDKnMR63NIO6
	 KCYNP/PHQTDBLjwlmHfqPTsZpLTGbOn5k8LmMbXeqqgQ5S6iPUvGUtiITvFgR+QddXCuo
	 mZKvpj8jrhKt1GyJTVBsEl5hI8+V6D//wJ4chKmK+2tleuMDrAfkvseR+w/rQAAoS3iNb
	 rHkvxQoK7Ydd6rpnOH2x/CRqIiPswyK7dACT9FAaN0G2SBi211Tj3woPOxMqDnjqBxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LmM2Fw9g;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EAC7606A31C;
	Tue, 17 Nov 2026 19:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LmM2Fw9g
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD2031F000C4;
	Tue, 17 Nov 2026 19:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794944778;
	bh=ExUxqEZt6CeU083ngWOHRCSyuGGcbWbRoHP3g8HyKtM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LmM2Fw9gfbDi+AVGhDZOn7ni51zlC4OkduYjfN3OBYRvdmfWDKkYPZ/YqivYYyoVB
	 CPf2z2Kj/kRf6q3kLA8XGFBtr9+0qUQ7N6QBOKcni0jUtLOTVjlnax82oAHDwjWu4Y
	 Wb/G/WW/jrS4grELIH7dPPX8KpI4RSnenwJ2u0vE1UMJbXLlfbrq3lsTTF8/u/aQaP
	 py54S1IeA7dJ9DDvZVOHfdEFotBHUh3P15g7p+6QfaC8hZOljl4qxGzF3SnwRoxEAw
	 a3WHCXcVXjBDOwKAyeOJdMeQpeaFQxF+dvYI0bItFrVlWpjOm3fNdphqpArg4MrbaF
	 sFIqZRxnLbXMw==
From: Danilo Krummrich <dakr@kernel.org>
To: Simon Song <xinmengs@nvidia.com>
Cc: dakr@kernel.org,
	acourbot@nvidia.com,
	kvm@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	nova-gpu@lists.linux.dev,
	linux-pci@vger.kernel.org,
	alex@shazbot.org,
	jgg@nvidia.com,
	yishaih@nvidia.com,
	skolothumtho@nvidia.com,
	kevin.tian@intel.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	markus.probst@posteo.de,
	jhubbard@nvidia.com,
	apopple@nvidia.com,
	joelagnelf@nvidia.com,
	ecourtney@nvidia.com,
	cjia@nvidia.com,
	smitra@nvidia.com,
	kjaju@nvidia.com,
	alkumar@nvidia.com,
	ankita@nvidia.com,
	aniketa@nvidia.com,
	kwankhede@nvidia.com,
	targupta@nvidia.com,
	linux-kernel@vger.kernel.org,
	zhiwang@kernel.org,
	zhiw@nvidia.com,
	boqun@kernel.org,
	daniel.almeida@collabora.com,
	tamird@kernel.org,
	work@onurozkan.dev,
	jgg@ziepe.ca,
	bhelgaas@google.com,
	kwilczynski@kernel.org,
	dri-devel@lists.freedesktop.org,
	peter@colberg.org
Subject: Re: (subset) [PATCH v6 00/11] Add Rust PCI SR-IOV support
Date: Tue, 17 Nov 2026 20:46:06 +0100
Message-ID: <20261117194606.1892840-1-dakr@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261111223337.508989-1-xinmengs@nvidia.com>
References: <20261111223337.508989-1-xinmengs@nvidia.com>
X-Patch-Reply: applied
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 11 Nov 2026 14:33:25 -0800, Simon Song wrote:
> [PATCH v6 00/11] Add Rust PCI SR-IOV support

Applied, thanks!

  Branch: driver-core-testing
  Tree:   git://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-core.git

[5/11] rust: device: clarify the drvdata_borrow() safety requirement
      commit: d66d8bbb0316

The patch will appear in the next linux-next integration (typically within 24
hours on weekdays).

The patch is in the driver-core-testing branch and will be promoted to
driver-core-next after validation.
