Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC3A32F12AF;
	Thu, 26 Feb 2026 22:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772143355; cv=none; b=kaaRtkt5a3Bpf3uR6PiyND4Vz4rxhYuHsWKsZ//fijVGpixgf+WkjwgKRhqBaOQPGutMi+D+P/IVuOQT2/ETq1eQKMkZh3x3xHsu+uXqTigHIZKB7XcaHM5rJCZx8Jk7ckGLhmGNKlWoIaRlhZrT5oxwi1/em8BD64sGmLU6oLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772143355; c=relaxed/simple;
	bh=4cyzJs1RMh3zb+ne2ukMQx5RBWPj0GMYnTgIp6y20D4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=hlPJsAS9p0n/L0cw0F7w3yQhNe4pTmG8Ci4CZ4ZJ3hJNFNWm6/6BqPhjv+v0on/q7e8l9ZgQQ5nOvXY37p6Bnmvw99P7gNHfwKgsn51VdFL1IWtGyCgnax9QorKwnsaiBaLYSg6IYjW1jeQeuPJjKQ9XWSl8TtdnQ3/nX6aODVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id EFF1E92009C; Thu, 26 Feb 2026 23:02:24 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id E9AA992009B;
	Thu, 26 Feb 2026 22:02:24 +0000 (GMT)
Date: Thu, 26 Feb 2026 22:02:24 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Matthew W Carlis <mattc@purestorage.com>
cc: ahuang12@lenovo.com, alok.a.tiwari@oracle.com, ashishk@purestorage.com, 
    Bjorn Helgaas <bhelgaas@google.com>, guojinhui.liam@bytedance.com, 
    Bjorn Helgaas <helgaas@kernel.org>, 
    =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
    jiwei.sun.bj@qq.com, linux-kernel@vger.kernel.org, 
    linux-pci@vger.kernel.org, Lukas Wunner <lukas@wunner.de>, 
    msaggi@purestorage.com, sconnor@purestorage.com, sunjw10@lenovo.com
Subject: Re: [PATCH] PCI: Always lift 2.5GT/s restriction in PCIe failed link
 retraining
In-Reply-To: <20260225014119.10047-1-mattc@purestorage.com>
Message-ID: <alpine.DEB.2.21.2602252156250.34294@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2602231829500.46231@angie.orcam.me.uk> <20260225014119.10047-1-mattc@purestorage.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 24 Feb 2026, Matthew W Carlis wrote:

> >  I argue that by applying this change the issues with NVMe hot-plug will 
> > be sorted while keeping the configuration working that 
> > pcie_failed_link_retrain() is needed for.  Win-win.
> 
> I don't think that what you are saying is true there is invariably going to be
> some other consequence of this change.. Its hard to believe there can be any
> changes to the pci drivers that won't break something.

 You're being sarcastic, aren't you?

 While I sympathise with your feeling, may I pretty please ask you to at 
the very least give my fix a try in your test environment?

> >  I note that active links are unaffected, so to say it's meddling with the 
> > link on every device is I think a bit of an overstatement, and reports of 
> > issues are from a few people only...
> 
> There is no discrimination about which device it can be invoked on..
> I'm looking at a fleet of millions of hot-plug'able devices.... I don't really
> know if it matters how many people report an issue, I think what probably
> matters is making the right change. Initially was there any other reports
> of the quirk helping with other devices besides the delock 41433?

 No reports that I know of.  Please bear in mind that the failure mode is 
such that you need enough knowledge of PCIe internals and the spec to 
actually realise there is periodic link training activity taking place.

 In the absence of the quirk for the average user there's just no 
communication, as with a dead downstream device (and the upstream device 
is sound as anything else plugged in, including but not limited to NVMe 
storage, works just fine).  In the presence of the quirk the downstream 
device just works and I expect hardly anyone can be bothered to report 
seeing "broken device, retraining non-functional downstream link at 
2.5GT/s" in the log.  It's only cases like yours that bring attention to 
the message.

> >  What outcome would you envisage had I taken the approach from this update 
> > right away with the original change?  My only fault was I have no use(*) 
> > for PCIe hot-plug and did not predict the impact there. 
> 
> What I'm seeing now is an overall confusion about whether a link failed to train
> to gen 1 or was recovered by the quirk or recovered on its own etc... In my systems
> I would prefer to NEVER invoke the quirk under any circumstances because I expect
> my devices to work. With the quirk it becomes more unclear about what the cause
> of a link issue might have been or whether it was even a real link issue in the
> first place or some weird timing.. 

 I can see your point.

 However from your description I infer this is about a test environment, a
development lab so to speak.  And you are a highly skilled professional 
who has access to measurement, test, and hardware debug equipment, and are 
therefore able to figure out stuff.  Conversely, the vast majority of 
Linux deployments is in the field, where no sophisticated equipment is 
available and the operator, if any, may have basic technical skills only.

 I have been taught that in the field it is more desirable for equipment 
to operate according to expectations rather than to strictly follow the 
relevant specifications and consequently fail operating.  And the quirk I 
have come up with just follows this principle, letting unqualified people 
use their equipment (this is similar to Postel's law if you know what I 
mean).

 I realise that in the lab you want strict compliance as this will verify 
interoperation of the devices you design.

 So I think we have conflicting objectives here and I can only offer a 
sysfs setting that will switch between the modes according to the specific 
user's needs, as the intent is not something the kernel can figure out by 
itself.

 Please mind however that throughout this week and the next I'm away on 
holiday (a proper one, as in alpine skiing), so my availability to respond 
or work on stuff is limited.  I'll appreciate if you give my fix a try 
meanwhile.

  Maciej
