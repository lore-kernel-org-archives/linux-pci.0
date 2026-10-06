Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4354A0152
	for <linux-pci@vger.kernel.org>; Tue,  6 Oct 2026 17:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791308407; cv=none; b=ooPQShRcftn0ARQY6Ni1Aq7Zifs9geRniX+StgOy6Jiyo/cjW1OuN7FvOMHnXkv3fSmN6V7UJgOfID3cvi/OPBQMHcB2vUJ7TE/jskXpRj/7j341H5S83F7t1J67mIzDIONbmxhxXT4ye4pf190Mm78EfHB1n7vbEo0G3JpJmPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791308407; c=relaxed/simple;
	bh=1KbkerHSko3TZwSDmuOS4OeNHxbqMxodwsBUHY74lDs=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=NTL/w8lY6Bg1gx42A6h2XSE9id5MH2fc1NoBAY4UwxUCSoCsIiXAVL3ShjXfvnhjv+lpnH6E4SE+8Y0PHmcgDM9SQdP8nOSS3UW1VAFrUKF1n9tZLU3ENQNuulQeqdi9Fjm5jjmoMaBr/ncYwa6Yu1bFBglaTT4wOeQ3AwajSyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=azd5ID5R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="azd5ID5R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E87FE1F0089B;
	Tue,  6 Oct 2026 17:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791308406;
	bh=1KbkerHSko3TZwSDmuOS4OeNHxbqMxodwsBUHY74lDs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=azd5ID5R4DiTljXZH4IA3tXFwW1fEjp+plKQHzxWSQkOpKb06oH5qwgxDRLux/K7C
	 CoYTgOigY65pCCxdc9syMUfvPLAnzAtgKCnXk00vwg21DfeuUZdJ6Gnq8SHv1aYDYX
	 hRH2zT3BMdQE5X01Dl6uP52tm2PyIzkjwsEIWz62xyHgtu8NM1URuGSSUCGrlIdhEV
	 WUclceKCcW+vAQ9ZtFHXw0IQa+CPfICqyF/0UJmoucLBvyA0yJLRk7igOt0dhQsW3P
	 Pvsj8s2fKOVmwurRxBZp1ZoIDZf9xPIK3O8h28lAI3GyStl3JcJwTiTsAwARrBTdII
	 gHU8m0/+XWSlw==
Message-ID: <sashiko-outbox-162301@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/2] selftests/pcie_lmr: Add tests for the Lane
 Margining debugfs interface
Reply-To: sashiko-reviews@lists.linux.dev
To: "Priyank Rathod" <rathodpriyank@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261006-pcie-link-endpoints-v5-2-c1e73235746b@google.com>
References: <20261006-pcie-link-endpoints-v5-0-c1e73235746b@google.com>
 <20261006-pcie-link-endpoints-v5-2-c1e73235746b@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 17:40:05 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Add a KTAP test for the Lane Margining at the Receiver debugfs
> interface.
>=20
> By default it only runs checks that do not start a margining session,
> on every pcie_lmr_* directory: the files exist, malformed input is
> rejected, and commands fail with ENOTCONN without a session.
>=20
> If PCIE_LMR_DEV names a port, it also starts a session on that link,
> checks the receiver and step bounds the receiver reports, and checks
> that Link Control and Link Control 2 of both ends are the same after
> the session as before it.
>=20
> Signed-off-by: Priyank Rathod <rathodpriyank@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006-pcie-link-=
endpoints-v5-0-c1e73235746b@google.com?part=3D2

