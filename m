Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794920489;
	b=u5QLG8siGaY0llgGyDys3yrtQDRKVJBKTYFOUdSme5MrzNyXNN9fMoY95U4l1Sd+5fWa
	 ZDzQRNsgg95hykpsJfjod8Cu1NzJdrHKnyrnzkiniILTn5oD1NQ5o/fB9Pct627XM/yFa
	 tae709qpYYV7/6494FhLzdRBzIg4+Q8ILrcqH+JAr+fGj0tdh3RnQ8EgWDixsPO2FD13V
	 +rWOt1Ui4P0VT5IXdx8nKFIW7n+KJUHJ+tX+KT6uvtWzuj7iV8vnf/2ZbcGZ3EfbxxxU3
	 oXtEdIECaL14wVQLIOVjPu5LTwqd145muKKuhJsC1bnZR46WcGLEYpP3vBatZ940IyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794920489;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=U2v6Sm4Exv5dODEhbJ5sVcdJP7KsFvG0De+9WtG1KHA=;
	b=rq/JI9Aroy2Gxcr7Ve8Z5BrDwU3Awav35gW9nZySeQpqvQrQP1mwd+QlqkxwaJRWF/Up
	 e69awMvEPwULNngSvJk9K8TILsmC7gtSdLNwnXvjMElEHLGPFbdAkQ0lOIuK+zXYBXizo
	 nB4ZWWkPrEK44Zbb+uaOa1TxDqGegMm5EUvMhp6tRjcyKpydmQPJCYufP7LT4KDo0Nupr
	 tend2JYJVwJrZeZ1YMqALjXzP4+8o8YXSqvI8cSHwjFf7baFL3O4VTMFznbTLc4VkAxit
	 /kzlmu0NxyKSW7Hf9iiIVd1cccNQ9+pvlsyDMYz+du6fYhvOnlPdwZUqDoYleqbV8xw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TxU4ulM7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C81F606A336;
	Tue, 17 Nov 2026 13:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TxU4ulM7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 301AB1F000C4;
	Tue, 17 Nov 2026 13:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794920489;
	bh=U2v6Sm4Exv5dODEhbJ5sVcdJP7KsFvG0De+9WtG1KHA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TxU4ulM766VNFg8TLpKkKUmqTFSud6Ci47WFsSEhx8YX/hp67GkI/j/QOVYvmgDEQ
	 XhV89J9SfYV9l/uBGMdEcpngywTppb5VOSyyMBj+0/LiX7Lfx9IiBmwWNoJXFcXZZp
	 S+kkxUkxjmj9LFnzE7mtSQCVjRtIREO1J2tj3v99LLouSPmGMGGW3zPG7t+Sex56vY
	 su4nwMYXmltZB62Ghc06uN2HYODw0TP7Dc/OkD9D50b62IOjtU8glMeccROD6AvFce
	 5Oyna85CbK+RUVX2hbPfJKixfuOtferAQopW0fY4ZgHkUGo966NL5iDef3csUgNOpd
	 s1R80Hj84MmrA==
From: Mike Rapoport <rppt@kernel.org>
To: kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	David Matlack <dmatlack@google.com>
Cc: Mike Rapoport <rppt@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>
Subject: Re: [PATCH] PCI: liveupdate: Factor out pci_dev_ser allocation and release
Date: Tue, 17 Nov 2026 15:01:21 +0200
Message-ID: <179492036728.3797246.8946625245628365286.b4-ty@b4>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109174009.735309-1-dmatlack@google.com>
References: <20261109174009.735309-1-dmatlack@google.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Mike Rapoport (Microsoft) <rppt@kernel.org>

On Mon, 09 Nov 2026 17:40:09 +0000, David Matlack wrote:
> Move the code that starts and stops preserving a device into
> pci_liveupdate_alloc_dev_ser() and pci_liveupdate_free_dev_ser(), and
> split pci_liveupdate_preserve_device() into separate paths for devices
> that are already preserved and devices being preserved for the first
> time. Leave a single refcount increment shared by both paths.
> 
> Since upstream bridges are preserved once for every preserved device
> below them, nr_devices is only incremented when a device's struct
> pci_dev_ser is allocated and only decremented when it is released, not
> on every preserve and unpreserve. Keeping that accounting in a pair of
> helpers makes the relationship explicit.
> 
> [...]

Applied to lu-pci-preservation branch of liveupdate/linux.git tree, thanks!

[1/1] PCI: liveupdate: Factor out pci_dev_ser allocation and release
      commit: 75181814fbd531e0e29833e8646825c6e5051e8b

tree: https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux
branch: lu-pci-preservation

--
Sincerely yours,
Mike.

