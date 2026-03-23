Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC1E38A725;
	Mon, 23 Mar 2026 10:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774261337; cv=none; b=hmeV5rzn3lqayCgYDfkpdv7G9qQDU7aMExOxdXM8myScI0rXKdbDG7Hy5jg6va1qMTbjbzybhqbaMOANAKB/cua32Moj+yvCTUaCo0uKd8zx8FaldFHWIt2UfZeg96UYV/jZ1MPQ2+D+vzckHS1DhdjEJOTGHnoBJAb1cemZ1Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774261337; c=relaxed/simple;
	bh=I8MT4pNsr9pBqQBFsnHiZXZFA8QlnXkZRFIHzVaEACM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N/p3Nm5Jp/KHNwl05yCTCt2a6gTm5CTRyg8HUMP8qEgomqvFD26lX7ok4rKchGGBAkKtrpApikP3EtgUV9uidvyZKOkjzr9bs7T9cQ8GFZS/7z30Qu//RZQ0iRMbMlQIRRpcTqG1ZVK1tLjFtkilkaeEHzY9C1k+griCJDUAnac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Esw9iDDp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Esw9iDDp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F1A6C4CEF7;
	Mon, 23 Mar 2026 10:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774261336;
	bh=I8MT4pNsr9pBqQBFsnHiZXZFA8QlnXkZRFIHzVaEACM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Esw9iDDpS0ZHpbJkjnvGVXPBNwzJ6Cd4PE29Lo+cVHr4EuQayPGSeXO3skjJreSCc
	 +Yumn6Lchhil29XJBwRT9pxurU24iJFl/Oulk0SU+r+r5DaRSQAlVUv3qVGlSTGRJV
	 iMhAuXG3uJZDs/rCbb2Fq8DahY2Ni/Ru93mx38pHZtF6HwIUi7yzJ4rJTRRShHJw5Y
	 dwbrqCmdOD8QTgLnhJUw7UOWt8bJMesVG+3RFPVG8x9jwxsBOot+KpZVa5vAvb29JH
	 Cy78XB4VSfhOztBa0xIcL4b2SCxKpTp6EH2s6Pl/8qq2lro/Ccp+WpcgcyqKMWzTcP
	 MLEYaalqBytnw==
Date: Mon, 23 Mar 2026 11:22:11 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Christian Bruel <christian.bruel@foss.st.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Shuah Khan <shuah@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Koichiro Den <den@valinux.co.jp>, fabrice.gasnier@foss.st.com,
	linux-pci@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] misc: pci_endpoint_test: Handle -ENOSPC in
 subrange mapping test case
Message-ID: <acEUU7pAbp7uF5tL@ryzen>
References: <20260323-skip-bar_subrange-tests-if-enospc-v2-0-2080f878134d@foss.st.com>
 <20260323-skip-bar_subrange-tests-if-enospc-v2-2-2080f878134d@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323-skip-bar_subrange-tests-if-enospc-v2-2-2080f878134d@foss.st.com>

On Mon, Mar 23, 2026 at 09:15:24AM +0100, Christian Bruel wrote:
> Return -ENOSPC when the status reports the STATUS_NO_RESOURCE bit.
> This signifies to the pci_endpoint test to skip this test.
> 
> Signed-off-by: Christian Bruel <christian.bruel@foss.st.com>

Reviewed-by: Niklas Cassel <cassel@kernel.org>
