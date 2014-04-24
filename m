Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 24 Apr 2014 16:45:12 -0400 (EDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Alexander Gordeev <agordeev@redhat.com>
Cc: linux-kernel@vger.kernel.org, Gleb Natapov <gleb@kernel.org>,
	kvm@vger.kernel.org, linux-pci@vger.kernel.org
Message-ID: <1917070890.8703765.1398372312996.JavaMail.zimbra@redhat.com>
In-Reply-To: <20140421133848.GC25116@dhcp-26-169.brq.redhat.com>
References: <1392804931-30671-11-git-send-email-agordeev@redhat.com> <20140221170504.GN17353@dhcp-26-207.brq.redhat.com> <530788C1.6030109@redhat.com> <20140221185620.GA18725@dhcp-26-207.brq.redhat.com> <5307C6D9.4030503@redhat.com> <20140222085030.GA26794@dhcp-26-207.brq.redhat.com> <530866A2.7080804@redhat.com> <20140421133848.GC25116@dhcp-26-169.brq.redhat.com>
Subject: Re: [PATCH v2] kvm: Use pci_enable_msix_exact() instead of
 pci_enable_msix()
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> > >>> So, do I have to pull something (which I'd rather not, since pulling
> > >>> the wrong thing in a submaintainer tree will make Linus angry), or
> > >>> should I do it in the next merge window after pci_enable_msix_exact
> > >>> gets in?
> > >So it is already in.
> > 
> > It is not, because maintainer branches are not rebased.  KVM
> > development is based on 3.14-rc1, and will not get that commit until
> > the first 3.15 pull request is sent to Linux.
> > 
> > No big deal, I'll include this patch in a second 3.15 pull request.
> 
> Hi Paolo,
> 
> I believe it is safe to pull it now?

Yup, vacation got in the way of doing this during the merge window but I
can safely send this for -rc next week.  It was on my todo list.

Paolo
