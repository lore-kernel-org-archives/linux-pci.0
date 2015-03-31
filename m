Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181]:32928 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752340AbbCaWi7 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 31 Mar 2015 18:38:59 -0400
MIME-Version: 1.0
In-Reply-To: <551B1FB2.3020203@oracle.com>
References: <5514391F.2030300@oracle.com>
	<CAE9FiQXw3QUCNNZj2SVhn-AYWWnggT=7JXPkGNpYFzq-qAB1aQ@mail.gmail.com>
	<551495EE.20201@oracle.com>
	<CAE9FiQXAD1ncuJ=ZiOSR4xCKbamPJ-5JSqEx1Veiai5bZKBcGA@mail.gmail.com>
	<CAE9FiQWwU4gsq4y0+BTMtisBGQDxF1m_pxAT62PmP-Ct+O1c5A@mail.gmail.com>
	<5515F6B8.8020606@oracle.com>
	<5515F782.7060301@oracle.com>
	<CAE9FiQXpNKrX9BuC5-sgb8XEdFPN1a-wBRR2XqY5Mh1cnhXSPQ@mail.gmail.com>
	<551623C1.2040300@oracle.com>
	<CAE9FiQUNLaNYAk6DoTDCAfbS=B1uks_=381KJDUk46+yg5cVwg@mail.gmail.com>
	<5516BF4B.9030901@oracle.com>
	<CAE9FiQV_BOKQu8+mCqQRx_RJYucwuGAfJog7qoUW0J_i=9u=Tg@mail.gmail.com>
	<55181065.8090807@oracle.com>
	<CAE9FiQXu8qvCo9Dx6vUBXEO029n8K=c=CGtsfvWMGYdVgqtgOw@mail.gmail.com>
	<5519D40D.20903@oracle.com>
	<CAE9FiQUVSRkKNRzh99JA7V8dqsY78z_GtnMnwTrpSFXkJV9CKA@mail.gmail.com>
	<551A1E32.1010309@oracle.com>
	<CAE9FiQWEZRYtk3sFU3U8ptZ5SvGtam65M-_wXXVEzcvuCWT3wA@mail.gmail.com>
	<551AD384.50000@oracle.com>
	<CAE9FiQU=9_NBiPNgaEBa3nOPBnCwGyj0ppOyVnf7RduKRe8K=A@mail.gmail.com>
	<551B1FB2.3020203@oracle.com>
Date: Tue, 31 Mar 2015 15:38:58 -0700
Message-ID: <CAE9FiQVTBWQnH_UcVtg3Z38=+qwJXvx8aLoTFF_2JaTY3zi8pw@mail.gmail.com>
Subject: Re: d63e2e1f3df breaks sparc/T5-8
From: Yinghai Lu <yinghai@kernel.org>
To: David Ahern <david.ahern@oracle.com>
Cc: David Miller <davem@davemloft.net>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Mar 31, 2015 at 3:29 PM, David Ahern <david.ahern@oracle.com> wrote:
>>
>> Please check attached three patches on top of current linus tree.
>>
>
> new log. Same as before -- PCI_DEBUG, ignore_loglevel ofpci_debug=1
>

Good, it is clean now.

Thanks

Yinghai
