Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:32769 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752284AbbC1D11 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 27 Mar 2015 23:27:27 -0400
MIME-Version: 1.0
In-Reply-To: <55161E5E.4040609@oracle.com>
References: <5514391F.2030300@oracle.com>
	<CAE9FiQXw3QUCNNZj2SVhn-AYWWnggT=7JXPkGNpYFzq-qAB1aQ@mail.gmail.com>
	<551495EE.20201@oracle.com>
	<CAE9FiQXAD1ncuJ=ZiOSR4xCKbamPJ-5JSqEx1Veiai5bZKBcGA@mail.gmail.com>
	<CAE9FiQWwU4gsq4y0+BTMtisBGQDxF1m_pxAT62PmP-Ct+O1c5A@mail.gmail.com>
	<5515F6B8.8020606@oracle.com>
	<5515F782.7060301@oracle.com>
	<CAE9FiQXpNKrX9BuC5-sgb8XEdFPN1a-wBRR2XqY5Mh1cnhXSPQ@mail.gmail.com>
	<55161E5E.4040609@oracle.com>
Date: Fri, 27 Mar 2015 20:27:26 -0700
Message-ID: <CAE9FiQXOWZLwfSbk-1y=8hCUSjGxWZSyPMxPMtF3_he5uT575g@mail.gmail.com>
Subject: Re: d63e2e1f3df breaks sparc/T5-8
From: Yinghai Lu <yinghai@kernel.org>
To: David Ahern <david.ahern@oracle.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Mar 27, 2015 at 8:22 PM, David Ahern <david.ahern@oracle.com> wrote:
> On 3/27/15 9:19 PM, Yinghai Lu wrote:
>>
>> Good. But we still have annoying warning about "no compatible window".
>>
>> Please try attached patch that support 64bit pci mem space for sparc.
>
>
> in place of or on top of the previous patch?

on top of the previous patch.

Thanks

Yinghai
