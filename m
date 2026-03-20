Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359E63BE14C;
	Fri, 20 Mar 2026 13:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774014226; cv=none; b=WAcVwv7ughwUJxR9UOZGxzpGHoI7dSc7OccROXhttOGyG9gujyejD+2GiS67W7ED+keADcsH2ILED59uIZnyO7xqqkfl0IuH8JR4/vQ5xZtC9zpEk6Hb4qv4/9B70r5789F5b8G/8YPf1U9PJPFCdSuUG6yEwY/DPbzPpJq0now=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774014226; c=relaxed/simple;
	bh=REdsHyTaW8dT1fc7fefZKHjbQODkQcLjcxpu1UnGYck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cUPnEnmYJMZ7mVFlgf8STr4KzjUx1ePDlNJhikF+N6ObH9740lhs+tzUEAAzsGom9o3HkrED4ELzleNHHIrPjtnJ/6x/x2gQwSfy6Dbc1Jmz+H6khH4bLFTOJhS0v7QSxMvboNZM4Lfaf1OYIes3F92SIq90ucHgDDRQsIx5V/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kfjxitld; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kfjxitld"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B18E6C4CEF7;
	Fri, 20 Mar 2026 13:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774014225;
	bh=REdsHyTaW8dT1fc7fefZKHjbQODkQcLjcxpu1UnGYck=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Kfjxitldh1RDpbKQynIQqf4B3nWNfmOIjM+QRv2m9sK/38emcCrGlv88MAiBacv2Y
	 88o8WM/dYf110MbVffMNs29TIfE9dBTy/GFjNFHotOtauPXt1gIpaVC/jB+xXbizjf
	 +HjkEMsGgAw8Y3mp8pSF/zjSHEK2h8LCFWmcylrq4yjGXQHV7KtKR5j1j/8tVlzzMT
	 iRe9TcndIKUHcErBilBxBKgyJleZNgZVqHhC3XUJQWCWgjboYkoU9g+eNvEzI+9UYU
	 zqAubJdri4pPgL9ll3KgkoSjuaaVsLFoDRAFSMyRsGfvtF3+fYiapZLJT3H+SlPMsU
	 PYLu6Dkveuntg==
Date: Fri, 20 Mar 2026 14:43:40 +0100
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
Subject: Re: [PATCH 3/3] misc: pci_endpoint_test: Handle -ENOSPC in subrange
 mapping test case
Message-ID: <ab1PDA1QBMXF_50E@ryzen>
References: <20260318-skip-bar_subrange-tests-if-enospc-v1-0-f1a49534ebea@foss.st.com>
 <20260318-skip-bar_subrange-tests-if-enospc-v1-3-f1a49534ebea@foss.st.com>
 <abrM0Jvo_sdWSTLc@ryzen>
 <28a71759-1095-4403-b356-d291a828daba@foss.st.com>
 <ab0seD_G4ER7R_9N@ryzen>
 <e6b385b5-f61c-4b0d-82ed-4018db76538f@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6b385b5-f61c-4b0d-82ed-4018db76538f@foss.st.com>

On Fri, Mar 20, 2026 at 02:25:10PM +0100, Christian Bruel wrote:
> On 3/20/26 12:16, Niklas Cassel wrote:
> > 
> > FWIW, I think an even better solution is to introduce a new register,
> > named e.g. errno in struct pci_epf_test_reg;
> > 
> > That way, we don't need to take a new bit, e.g.:
> > +#define STATUS_BAR_SUBRANGE_SETUP_NOSPC          BIT(18)
> > 
> > For every unique error code a command can return.
> > 
> > We would simply return STATUS_BAR_SUBRANGE_CLEAR_FAIL, and then the host
> > side driver looks at the errno register to see the specific error code.
> > 
> > This way, all other _FAIL commands could also return a more specific error
> > in case of failure.

(snip)

> But it is not consistent with other tests that use the status field to carry
> error information. For example, pci_epf_test_read/write/copy, set the
> STATUS_SRC/DTS_ADDR_INVALID bit to distinguish these errors from other
> -EINVAL.
> 
> Introducing a new errno field would result in having two different APIs for
> returning failure status.
> 
> In light of the STATUS_SRC/DST_ADDR_INVALID usage, I wonder if my initial
> proposal to set a status bit along with the FAIL bit might actually be
> simpler and more consistent what is already done here.

You are right that the read/write/copy tests actually set two bits in the
status register.

With:
#define STATUS_SRC_ADDR_INVALID         BIT(7)
#define STATUS_DST_ADDR_INVALID         BIT(8)

Potentially being reused by the write/copy/read tests.

At least these bits are reuse for more than one test case.

So, perhaps to keep things in line with the existing design
perhaps just name the new bit something like:

#define STATUS_SKIP_INSUFFICIENT_RESOURCES	BIT(18)

or something like that.

At least then, other test cases will be able to reuse this status bit,
just like multiple test cases can use the STATUS_SRC_ADDR_INVALID status
bits.


And yes, I agree that, like you do in your initial proposal, having this
new STATUS_SKIP_INSUFFICIENT_RESOURCES bit set in addition to the
STATUS_BAR_SUBRANGE_CLEAR_FAIL bit, is probably the best way forward that
is in line with the current design.


Kind regards,
Niklas
