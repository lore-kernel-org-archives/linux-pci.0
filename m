Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F43D1D5160;
	Thu, 19 Feb 2026 16:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771516802; cv=none; b=Fd0VWTcIIomUzai9bW/fyoVuJvHLLrr75s60Xn6papQSKGga+LVSGumGbTlhacCmmdLhNTdYfZqo013NejI5R6o65vi8V6OHs7+Ot4xe6Elnq500fjLwChAK9SBpk8veO59ar6lQe3zIlthKiWzbVVP28iSZBRlQFMShpY/p284=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771516802; c=relaxed/simple;
	bh=0v/L4Xesw/whMXC5xx+pNjMoEam92Sd85B3MP7yKj50=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=hF4PZUTUdweWLt8uQOKR5KTEnZ8oIFehCirwIXwzVlEnln0iLnPyFwz2/Fa+ggqB0VzoiX2LKXjGJdpGd+hImzoJe6pL9V+4mSTySER0wac3w3e25/KnZGWi78jGMIppRZD3e1RuXjD/SL7PjwHo0l2fKd4Z1Ug8Bssz7M8EGJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dcxTfZPj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dcxTfZPj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3B8DC4CEF7;
	Thu, 19 Feb 2026 16:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771516802;
	bh=0v/L4Xesw/whMXC5xx+pNjMoEam92Sd85B3MP7yKj50=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=dcxTfZPjMlojLC1vKYkCtUiJIX0r38JcIOE+hQHvRA4MLGylqx7xVIEDllbcrN2sr
	 D2s//k9e6KOaq2b4ovmM5PLHn7SdZD8G7N47JpBrrDYMGO/gF1GizIFXY8oMp6PzlB
	 YI9Zm9pggJFi55WaVocx1wFqhigFb2daAxcMjtHmzlPOysooaHAjGtVLiTmPYFQvFh
	 nvHBqp/ocCZ2RW2KF9r4AFCPTXzZLd+GxOiuZCFgw3r7ydNbhPBOY2KkcT3amjJ3DK
	 t8u1YpSe8iegk1F57JTpKUAQaqqWSKYBVzDSlAxvZXwcmHPpXNfzpmxLNlvScrMdX7
	 akdxRiCn8+2Zg==
Date: Thu, 19 Feb 2026 10:00:00 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Arnd Bergmann <arnd@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: endpoint: pci-epf-test: select configfs
Message-ID: <20260219160000.GA3477038@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZbRkXM2vIgAwvzz@ryzen>

On Thu, Feb 19, 2026 at 10:02:16AM +0100, Niklas Cassel wrote:
> Bjorn, btw, is it perhaps possible for you to remove the tag:
> pci/for-linus
> 
> tag pci/for-linus
> ...

> Since most people why do a git log pci/for-linus wants to see what
> you have queued for linus, and since the ancient tag seems bogus
> anyway, perhaps you could just remove the tag from the PCI tree?

Thanks for reminding me about this.  I've tried in the past but was
unsuccessful.  I tried again and I *think* got it removed.  I'm
including the details in case I ever need to do this again :)

Current pci/for-linus branch in case I delete it by mistake:

  $ git show --oneline for-linus | cat
  a7b3343bbb57 PCI: endpoint: pci-epf-test: Select configfs

Local pci/for-linus tag:

  $ git tag -l pci/for-linus | cat
  pci/for-linus
  $ cat .git/refs/tags/pci/for-linus
  b4aef5ce82f1d27e0f14d1f8488dc2db9c22dd38

Delete local tag:

  $ git tag -d pci/for-linus
  Deleted tag 'pci/for-linus' (was b4aef5ce82f1)
  $ cat .git/refs/tags/pci/for-linus
  cat: .git/refs/tags/pci/for-linus: No such file or directory (os error 2)

Delete remote tag:

  $ git push --delete pci pci/for-linus
  remote: Recorded in the transparency log
  remote:  manifest: updated /pub/scm/linux/kernel/git/pci/pci.git
  To ra.kernel.org:/pub/scm/linux/kernel/git/pci/pci.git
   - [deleted]                   pci/for-linus

Verify:

  $ git fetch --prune --prune-tags
  $ git tag -l pci/for-linus | cat
  <none>
  $ git fetch pci
  $ git tag -l pci/for-linus | cat
  <none>
