Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A303845D1;
	Mon,  6 Apr 2026 15:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775488042; cv=none; b=OFyDFN7Ex8B3AYtnKAbjCFCSXCimmzJXVj55UQohLgBtjK9eEsAgbn/xvBoYCKf65imxGbivTNwlG+JNW6t4dbLu36BdyOegcnvOeyuGcgtMySOy/Fw47snlyMZm4pgNlIB8iS4WVpP40aAlU+TwiVUk27TauYpyCRjWNC8hXHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775488042; c=relaxed/simple;
	bh=PM29/z47n2zYsho8v6UFDaJ35khN7jsuy86PKsuhmhE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S3OH8eDhFHVj9kqB6lBEcPv7TUZKOHQ7oRSbbExIKppKxSR2l4N6+YMOs94J9qjGaaoOmodJ5zZNxINVl4pcYdG0VKiHrTdilqkBwzKbbdEhQMFg+Hh01dl2/k/aJS+Dp9fIJw+sEQymrqMOhYsYOGimt+mr/dZuhJhAVGYFDMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf14.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 327D01B7FCF;
	Mon,  6 Apr 2026 15:07:20 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf14.hostedemail.com (Postfix) with ESMTPA id 4EAE930;
	Mon,  6 Apr 2026 15:07:18 +0000 (UTC)
Date: Mon, 6 Apr 2026 11:08:29 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, Bjorn Helgaas
 <bhelgaas@google.com>, linux-rockchip@lists.infradead.org,
 linux-pci@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH v5 0/3] PCI Controller event and LTSSM tracepoint
 support
Message-ID: <20260406110829.12f3e445@gandalf.local.home>
In-Reply-To: <u2dh2os5qyuuv636uwzttvohfyics7tvqiobheftjzdnuegq33@n77svn2nlqu2>
References: <1774403912-210670-1-git-send-email-shawn.lin@rock-chips.com>
	<u2dh2os5qyuuv636uwzttvohfyics7tvqiobheftjzdnuegq33@n77svn2nlqu2>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: ixe9nnprriq7mxpun5m6gf7xrpof86fk
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 4EAE930
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/uYBeCRxOtEh7TrxbGKZNQKuDClwoTA6I=
X-HE-Tag: 1775488038-770766
X-HE-Meta: U2FsdGVkX18p9VDqkHnORGbRcc0QXG5XI9F5Ld8pli7hj98TQXd50dWcWXwmuezbwzTOF//49UhUyN8vmkZhb5O4V6oiYTqoJ0OHNbW4GeD9jH6m4scWiK8gOWNBog8KJ3mwtCtegVRpUAWg37UUFmVKL88Y4IP2AoNCasIDXtokUk/nBJ1CaLVJtBhPtAHo9q4DokbOH9u+1AT3lSJ3XmUCZ/EDUT8i8x9JcCmkhCQalQbiulTpKc4avizmzJbzoWgVok8maeIWCVCKpzq21xyobxhFqOxx/hmE3ntQaCZHBELuEMao8Hp9J9VHmEptllvBa82VzULEnaDiGNp5WeYs5ylaz3o90+7z9tbINzusWfK12+Rq5MhawtuHBnXrzW8d5tshpNkY+aYCvL0Rlg==

On Sat, 4 Apr 2026 22:23:32 +0530
Manivannan Sadhasivam <mani@kernel.org> wrote:

> On Wed, Mar 25, 2026 at 09:58:29AM +0800, Shawn Lin wrote:
> > 
> > This patch-set adds new pci controller event and LTSSM tracepoint used by host drivers
> > which provide LTSSM trace functionality. The first user is pcie-dw-rockchip with a 256
> > Bytes FIFO for recording LTSSM transition.
> >   
> 
> Steve, could you please take a look at the tracing part?

I already have but didn't say anything because I didn't find anything ;-)

Anyway, for the tracing part:

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve
