Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795868799;
	b=prP3miFy9RM/SMPXZb+bBM52DCMRDFCQBlBwWZX6q+y9owpAEPA2QgxroqRP93lOSER/
	 l9bFOc3vnIkCQwbGoMP0sZBbvYlT+v10Lk8QRaZB9zJVaCMJB1Tp7FgOXduxAmVDp5CUl
	 9qQu+yLwcdfgfX7bvVxRzC4J1JdxV5gaY8tdNUKgliyc+Zwjr4CUL9AorQ2RYhUfuYxGn
	 x2nD+RMpLC5GIjv40dk+cFWAIt77gn8eJXCM53pb84YyMGOqCaLwNCkS+u2BNkbhWZ6z8
	 GRhS7tMH4zzkDEm4kKTeG5wqqva9u82nIcms9uAbWhjd8rRN/qTR8ODzi2Ya0UTNW/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795868799;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=QP5xxOk3TtiXC7aqF5ul4oSYLJF6/7yQvq7C7sPOAwI=;
	b=WJfxw614RGYS2ZHpOzrHyXAKAJeD6qS5aT1y0AGlF7/QfPSmVFV0kBWVg4giWnZZ1EZa
	 KEBz0kXV1jBnLsTWgtGiEpnOef82DmSl7YIzWl7lGWPv6HCxU+0XBUFaP1o6w7MUt8hEs
	 LCp89wPGkEW2BydQvvEmGiJPuS/GZdyC53p1Yptl9G7ElAJB20pBkRRMx+AGLSwxAnUlr
	 F3P/hnSekV37zpfmJyexk6798DP5RyxXNL7Bsz6T/GJFmjdVtNUw0jh/SJdixTO/zmU3f
	 tV4LI3uJEbPe8ArIAZD+K2ERoL0FbCJJq12RYhaPNkqBzuWQAsO4f+3Mulhfp2+ONbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I9wzZAMZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A96E606A31C
	for <linux-pci@vger.kernel.org>; Sat, 28 Nov 2026 12:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I9wzZAMZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2C581F00923;
	Sat, 28 Nov 2026 12:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795868799;
	bh=QP5xxOk3TtiXC7aqF5ul4oSYLJF6/7yQvq7C7sPOAwI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=I9wzZAMZDRfEz7QebcBQTCf6PA7hqEoF0OXBUFjBmnsZdTN8KyWB45zEMKZpKdchc
	 iuqlCMwaIs4m5QNrhjKACWS04qq/jC+K1scL8BH9epQoHwd8MdhDYGRPiBPpkzzl9M
	 Vr7f/3WsKIMaiGWVMpybYAXEyFE6Uh9Y/kqxOR5Gi42c8KfG8JXa6k0koQ6hJlsAQS
	 z70PeE3BgJRe9T6PIJiYexhmbDYDmtoh+bZ9JNii00qLEXJX/tBwT3vEjwShNs0RD2
	 P0E3dYed+T5PLnJ9Kcs2UUurqCX9W1Rjc5KVFeIUVL6FnIy+p8M94ra98O+qQcXK3k
	 ES4YRuxYQKJPg==
Message-ID: <sashiko-outbox-238691@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 0/6] kho: housekeeping
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pratyush Yadav" <pratyush@kernel.org>, "Mike Rapoport" <rppt@kernel.org>, "Pasha
 Tatashin" <pasha.tatashin@soleen.com>, "Alexander Graf" <graf@amazon.com>, "Jonathan
 Corbet" <corbet@lwn.net>, "Shuah Khan" <skhan@linuxfoundation.org>, "Randy
 Dunlap" <rdunlap@infradead.org>, "David Matlack" <dmatlack@google.com>, "Bjorn
 Helgaas" <bhelgaas@google.com>
Cc: kexec@lists.infradead.org, linux-pci@vger.kernel.org
In-Reply-To: <20261127122536.3708770-1-pratyush@kernel.org>
References: <20261127122536.3708770-1-pratyush@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 28 Nov 2026 12:26:38 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Sashiko has finished reviewing this 6-patch series:

- Patches 1-5: no issues found.
- Patch 6 ("kho: don't reference subtree blobs as FDTs"): 1 potential
  issue (1 Low)

A detailed review has been sent as a separate reply to patch 6.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127122536.3708=
770-1-pratyush@kernel.org
