Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793754404;
	b=Y/xMoQg2gj1oBD+I0OeqhBVxVtTIdAzUIkvM+dO6TqBJ3rM4xREq3kryCIGaLRg7fhx1
	 41BBHkWX2Vl3tF/ABdi9GtJgvqo3eJzTS8fK5QlpwX8e3dLymmCA2s1nEOooxRrAIbaw5
	 4zQvWjUF2UfPwR8/o93MwWjTnNfmdteQHFHaaJkRL+e81yj1zN9lQVU4HxuKH+o3hzc+b
	 SXsSuQcrl0VZ1Rq19nhtlwpwbKRAFFL13nj8WZxN/kVKzEML+XnO+kikV724qJASo3+Y0
	 NZCvfpY0C59Pkm61Q62GAjCUirdJStChCHh/3O7Pf6xQQdgkEM7o5YytDKas4ZNzI5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793754404;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:To:cc:
	 Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type;
	bh=nM390zJfDJhH3r1E7uK0oCMzgHFhkctGH9GBoslOWqg=;
	b=J6RVCfBC0Tuohz9CyvhOy+1+tFm6rSu5m7RVzBxnL+gZRbZ0tdRoRTdMtZutsZOKM2MK
	 XagqxL52G1U5R71RYDdRJPJdrBcuRkaDEWhDYYd7IsTAAU39CACjxKc+cr57G9XzUG7fP
	 oWE/GtYF9ryPzhzAhOAmvhvUjLlkWMxmRfHeEdluh+eDern4oFmAfZh3FsLnglPr8iJUr
	 fT0XKnJS5iCUhAmk48XTT0NGOwbXAhPEs/f0buzzDUkgNwzkX77foY8Su3HOL6aY9KDnI
	 fPJqPYEvG6GJxC28tBOWTwEolbybtwpIulO8AI5rk8iyvv2M4vUtXiA1ZzsDYkur+bQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=E4K12+af;
	arc=none smtp.remote-ip=198.175.65.12
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56640606A31B
	for <linux-pci@vger.kernel.org>; Wed,  4 Nov 2026 01:06:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56640606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=E4K12+af
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793754404; x=1825290404;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=85EkBDYhA8YsKy22XUqQ7C8WjlCRnrkM13drPAUQTiU=;
  b=E4K12+afjP0XneMzzzJjd/YN4pmsSJFyaJ3vzXdkfmwLN8rzb1XZnMUW
   roo2J8Dhh6dCYGt41fDlHtZnYIE5lQ6m9HmcjpltcO7Qqy4S68WPqWPgm
   zV6dd0dXJ1oYEYArx7ZcPSw5jaSXrfA3MuUz1QyihGvn0H6PGS9lK9adH
   6cG8tF1YVUwcLxW6xMu/wPuTUbyaGlC2Y2XWnfSaJFd90WvrzrlCcVs/t
   ACX2qH4igyHa7sltQdmZq3FyMh1pUE5Ip5T9IS8/eX5hoqU5A6AsZQUbr
   W5FHBRPMGGI5iYvDFEoRgH3xs02H4ENb/nNKbR2RC/oTPAhs29vwMgVny
   g==;
X-CSE-ConnectionGUID: ba97rocfTdO+i3dGFf1pGg==
X-CSE-MsgGUID: O3uPMlFKSQG/7h4+ZE4xpQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2376722"
X-IronPort-AV: E=Sophos;i="6.27,194,1787036400"; 
   d="scan'208";a="2376722"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 17:06:43 -0800
X-CSE-ConnectionGUID: A/iUfZu8T1OABz3P35Q1ig==
X-CSE-MsgGUID: dp1Tb637Q66SJg7n9HNtJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,194,1787036400"; 
   d="scan'208";a="6916218"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.225])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 17:06:39 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 4 Nov 2026 03:06:35 +0200 (EET)
To: Bjorn Helgaas <helgaas@kernel.org>
cc: Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org, 
    Sourabh Jain <sourabhjain@linux.ibm.com>, 
    Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org, 
    Alex Deucher <alexander.deucher@amd.com>, 
    Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, 
    Keith Busch <kbusch@kernel.org>, 
    Maciej Grochowski <Maciej.Grochowski@sony.com>
Subject: Re: [PATCH 2/2] PCI/AER: Check validity of Error Source ID
 register
In-Reply-To: <20261104004609.GA1167435@bhelgaas>
Message-ID: <6cdf31f5-63ce-a232-5bdd-d45a67f0a384@linux.intel.com>
References: <20261104004609.GA1167435@bhelgaas>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-547830596-1793754395=:1105"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-547830596-1793754395=:1105
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 3 Nov 2026, Bjorn Helgaas wrote:

> On Tue, Nov 03, 2026 at 02:57:58PM +0200, Ilpo J=C3=A4rvinen wrote:
> > On Tue, 3 Nov 2026, Lukas Wunner wrote:
> >=20
> > > Certain Intel and AMD Root Ports are known to populate the Error Sour=
ce ID
> > > register with an invalid value.  The AER driver seeks to recognize su=
ch
> > > buggy silicon by assuming invalidity if the bus number is zero.  It t=
hen
> > > searches for the error-signaling device in the hierarchy below the Ro=
ot
> > > Port.  This was introduced by commit 28eb27cf0839 ("PCI AER: support
> > > invalid error source IDs").
> > >=20
> > > Alex has provided dmesg output which shows an invalid Error Source ID=
 with
> > > a non-zero bus number.  The AER driver's heuristic fails to recognize=
 its
> > > invalidity:
> > >=20
> > >   pcieport 0000:00:07.1: AER: Correctable Error message received from=
 0000:01:00.0 (no details found)
> > >=20
> > > The Root Port at 0000:00:07.1 has subordinate bus 04, so an error sou=
rce
>=20
> I always think "subordinate" is just slightly ambiguous because it's
> used for both "anything below this bridge" and the more specific
> "Subordinate Bus Number" (the highest numbered bus below the bridge).
>=20
> It's perfectly accurate as-is especially because in this case it looks
> like Secondary Bus Number and Subordinate Bus Number are *both* 04 for
> 00:07.1.  But "secondary bus 04" seems less ambiguous to me.
>=20
> > > on bus 01 is obviously invalid.  The range of subordinate buses is ca=
ched
> > > and checking against it is cheap.
> > ...
>=20
> > > +=09return root->subordinate->busn_res.start <=3D PCI_BUS_NUM(id) &&
> > > +=09       root->subordinate->busn_res.end   >=3D PCI_BUS_NUM(id);
> >=20
> > I kind of hate the order of this logic. I understand you're probably=20
> > doing it for the alignment which has some value but...
> >=20
> > ...For me, the more logical order would be to keep these in increasing=
=20
> > order even if doing it results in losing the alignment:
> >=20
> >    start <=3D val &&
> >    val <=3D end
> >=20
> > Maybe that's just me and it's not an end of the world either way.
>=20
> I agree, I think "start <=3D val && val <=3D end" is more readable, thoug=
h
> not quite as pretty.

I suppose a local var could be used to shorten the derefs and it would=20
even fit to a single line then.

--=20
 i.

--8323328-547830596-1793754395=:1105--
