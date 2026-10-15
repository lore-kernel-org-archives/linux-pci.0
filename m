Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F90F4FD788;
	Thu, 15 Oct 2026 11:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792064457; cv=none; b=WaQvoH1WORnU7ny34naZ95O12Zb1+zIJayCttmAm9+IXZ1tPqlSmTzlGSwgHaJJSzmIIEdReHvT1S9jpLqKcm/Rrax60Q5EY8OEBk/iSCNARxjN6g6VxRB81Gf9JkRGgfotS31atw/vZKvP9EUfAUKJbaPYZtCwR6Cmyq/3haRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792064457; c=relaxed/simple;
	bh=Z3LxCp/jzQ3HoDqIea+VzoqSMdBnOH3ih5Khyb73lXY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=aPFkPucOYonQw8VyOCmrwd06WFbQaSLaf4u+QOtHtFhLJ2UkTFH3RHOYmPQJUmXRbkjjRQRwGkv3hPN4YgErOalzZah5JJxKh2kYSIsPbxPsyjFKZqzYbtfWpDwm4fcxr7JzTkkRSiOgaHAfvIXO1ZUH7Iau4GJLf9p2YjVukeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 974A292009D; Thu, 15 Oct 2026 13:40:41 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 93A2392009C;
	Thu, 15 Oct 2026 12:40:41 +0100 (BST)
Date: Thu, 15 Oct 2026 12:40:41 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Deepanshu Kartikey <kartikey406@gmail.com>
cc: David Laight <david.laight.linux@gmail.com>, 
    Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
    linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
    syzbot+7134530b25073b4ef373@syzkaller.appspotmail.com
Subject: Re: [PATCH] PCI: sysfs: Reject unaligned resource I/O port
 accesses
In-Reply-To: <CADhLXY65fwGS=87oOtyAi9V4oXjbr8jgJNcSc0wXkVV9OOsREw@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.2610151234560.55767@angie.orcam.me.uk>
References: <CADhLXY7008e4JA35T2wE8TnJnR_r82RCpfSd=aLBmDh5xAQ02A@mail.gmail.com> <20260923205518.GA1941939@bhelgaas> <20260923225059.5c8cf0d7@pumpkin> <CADhLXY65fwGS=87oOtyAi9V4oXjbr8jgJNcSc0wXkVV9OOsREw@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 28 Sep 2026, Deepanshu Kartikey wrote:

> > > What do you think of the sashiko comments:
> > > https://lore.kernel.org/all/20260809051652.36BA31F000E9@smtp.kernel.org?
> > >
> >
> > You could just add 'if (port & 1) return -EINVAL;' to the 'case 2:' branch,
> > and a similar '& 3' to the 'case 4:' one.
> >
> > Did it miss that loff_t is (probably) 64bit on 32bit?
> > Or do large offsets get detected earlier?
> 
> Thanks David for the suggestion. I have send patch v2

 FWIW it seems like overengineering to me and obfuscating the intent.  The 
call to IS_ALIGNED will correctly reject unaligned addresses for correct 
values of `count' and incorrect values of `count' will then be rejected by 
falling through the `switch' statement.  Also I expect extra machine code 
produced with the individual checks.

  Maciej
