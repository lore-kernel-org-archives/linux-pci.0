Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4BC2F5A06;
	Tue,  3 Mar 2026 13:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772545612; cv=none; b=SDqxklaLC06amTAdWMcUHr8UpUieizM1SAkH2cPLM/ewHpcblLzw85qowbIO78v+nWNS+9yVs7rHsq/tgeIrsjX5lhl53+qeQzFs5No5Vc5ZSUTe2uYaM2JlNtdt9Vy0OAgyYkrP85P4YtEyDVZf695y15LeoHA4ErAw6LZ6Y6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772545612; c=relaxed/simple;
	bh=eeJCjoio3Z7PYW8zPTxB90lfcjKBpsIHjf2YdQUK390=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qBq+UQUSWoXl9FtvdGQ4ZyP5YH58xvggcgAeSsSZspHazz8MBZmeKx/wSaie4+gZzVq2kBzHXU8jB8Rtm4MUTtPB4qcUC+IZmUEDBEU/kODLiKj//uDsObJUlG4to2R7Ytx6FjVKQXbASkpKsMVR0923EnuKiEepgyjChBMPZ1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u9QEoSvR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u9QEoSvR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB6DBC116C6;
	Tue,  3 Mar 2026 13:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772545612;
	bh=eeJCjoio3Z7PYW8zPTxB90lfcjKBpsIHjf2YdQUK390=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u9QEoSvRxxrmrAjzjmwQB9kzPinIm+/SQoZx3uz+g+xbAvkfDWR//JfGgC9gMbHpX
	 WIWDj5K12XZxBrGCnLef1JZqUhws7HXYYpoxa4TqjoeVhS3lhrahc6shy7AE7imGBN
	 6BjhM+gLx1IrSvcFKEpjqMdZbu46jAunKP9sp/wze5rcpGGLVr3B8SEdk5Jeh5XOkc
	 pqGisx35C5mQjOG5WrmfnbfNIYVOSrqq1QSCkdlNeZhu4FLnX99i4EppPVyunvGelR
	 yQVbUQR/WZMFz/9qbMW9g3zlmdf+kgJTH6X3q97zKfDu8fBOTqdqclUkBTOpsJmhxC
	 NGJr5Xf4nAbxQ==
Date: Tue, 3 Mar 2026 14:46:45 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
	mani@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, thierry.reding@gmail.com, jonathanh@nvidia.com,
	kishon@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
	Frank.Li@nxp.com, den@valinux.co.jp, hongxing.zhu@nxp.com,
	jingoohan1@gmail.com, vidyas@nvidia.com, 18255117159@163.com,
	linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] PCI: endpoint: Allow only_64bit on BAR_RESERVED
Message-ID: <aabmRaW5oKuNt7_X@ryzen>
References: <20260303072004.2384079-1-mmaddireddy@nvidia.com>
 <20260303072004.2384079-3-mmaddireddy@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303072004.2384079-3-mmaddireddy@nvidia.com>

On Tue, Mar 03, 2026 at 12:50:01PM +0530, Manikanta Maddireddy wrote:
> Remove the documentation that forbids setting only_64bit on a BAR of
> type BAR_RESERVED.
> 
> When a reserved BAR is 64-bit by default, setting only_64bit is the
> most accurate description. If we later add support to disable a
> reserved BAR (e.g. disable_bar() for BARs that were never set via
> set_bar()), the implementation will need to clear the adjacent BAR
> (upper 32 bits) as well; having only_64bit set documents that
> requirement.
> 
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> ---

Reviewed-by: Niklas Cassel <cassel@kernel.org>

