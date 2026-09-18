Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 324B44E73CE;
	Fri, 18 Sep 2026 12:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789733942; cv=none; b=FkDPQazKfLLBYcObJRn/RGsMrMkXsLaqa7i6OIk0ZWZ7hYLF0Pgp/7vZCE4osH9T8Nnj8+yLIBj++8qINrpJu5QkpwjVfJM+iu8GBCV2ELChiT9bZ9+42omh4L2pNZdlzpF1j9C1ORvX7PQQ4DfI1sXsqYA+03YdGsA0WJaFOow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789733942; c=relaxed/simple;
	bh=xR7N3jaaqQFOlHkE89dk1XDeEQR4y5F5/5sFkR8vaiA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=WaIooxq9hwx0yorW6qN8lF27AgpIeiSbyeXYjjS/k9lkV2+CQTkX0ctsOMnrsk4wyUDog86dHQcNfJXkyMQc8hAJCIfeTBSiyOMMpAuUS19pJKEJZGrlMqB3twmUg6EK/mrL5Q/qR8FOmIbMdEwwa/WBcEEEViLUbSsERNqHDFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id DFE4A92009C; Fri, 18 Sep 2026 14:18:51 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id DD5FA92009B;
	Fri, 18 Sep 2026 13:18:51 +0100 (BST)
Date: Fri, 18 Sep 2026 13:18:51 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Thorsten Leemhuis <regressions@leemhuis.info>
cc: Bjorn Helgaas <helgaas@kernel.org>, Andreas Wild <andiwild@gmail.com>, 
    linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
    linux-kernel@vger.kernel.org, M M <restafvalendergelijke@outlook.com>, 
    regressions@lists.linux.dev
Subject: Re: [PATCH v3] PCI: Skip Target Speed quirk on clamped ports with
 no link
In-Reply-To: <6846f455-fc77-4cec-974f-6b9d72ae0654@leemhuis.info>
Message-ID: <alpine.DEB.2.21.2609181231300.57799@angie.orcam.me.uk>
References: <20260917233355.GA1115024@bhelgaas> <b4ed1637-ac6a-4af5-ab47-e07309af200b@leemhuis.info> <alpine.DEB.2.21.2609181131520.57799@angie.orcam.me.uk> <6846f455-fc77-4cec-974f-6b9d72ae0654@leemhuis.info>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 18 Sep 2026, Thorsten Leemhuis wrote:

> That being said and wrt to the "a lot going on": seems this causes some
> devices to not work for iirc at least two reporters. Would it maybe be
> better to revert the culprit and reapply it later once that is sorted
> out? Or is this not an option or a bad one for some reason? Reminder,
> normally Linus in a situation like this wants regressions ideally 'fixed
> "within a week", preferably before the next rc':
> https://lore.kernel.org/all/CAHk-%3Dwi86AosXs66-yi54%2BmpQjPu0upxB8ZAfG%2BLsMyJmcuMSA@mail.gmail.com/

 Reverting will cause other configurations to regress, so this would be 
replacing one regression with another.  We seem to be in a situation where 
there are all kinds of breakage out there worked around by the system boot 
firmware by capping the link speed, and this quirk interferes with that.

 One way to handle this could be by having a list of downstream devices 
never to remove link capping for.  But that seems like a recipe for an
ongoing maintaince burden.

 Ideally we'd handle all the cases gracefully, even possibly out-of-spec 
ones, but it seems more and more evident that this may not be possible.  
It may be that the quirk will have to be dropped entirely after all.

 Thoughts?

  Maciej
