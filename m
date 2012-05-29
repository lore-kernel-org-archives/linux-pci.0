Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e28smtp04.in.ibm.com ([122.248.162.4]:51407 "EHLO
	e28smtp04.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752768Ab2E2L7J (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 29 May 2012 07:59:09 -0400
Received: from /spool/local
	by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Tue, 29 May 2012 17:29:06 +0530
Date: Tue, 29 May 2012 19:59:00 +0800
From: Richard Yang <weiyang@linux.vnet.ibm.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Richard Yang <weiyang@linux.vnet.ibm.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: One problem in reassign pci bus number?
Message-ID: <20120529115900.GA31679@richard>
Reply-To: Richard Yang <weiyang@linux.vnet.ibm.com>
References: <20120410090306.GA7056@richard>
 <20120422155202.GA13540@richard>
 <4F95B17B.3030401@redhat.com>
 <20120514015536.GA3331@richard>
 <CAE9FiQUjxH+LWy2zbbL6TVQSMZ44i9grFBZf0ZZQFPEWRKANMw@mail.gmail.com>
 <20120514064615.GB26605@richard>
 <CAE9FiQUuHFoEXMz_Va+FOGnqEbi9=cnnoSB+h7Ug2e4Y2sFTGQ@mail.gmail.com>
 <20120516011833.GA6599@richard>
 <CAE9FiQVUcYu-KM8fBs3zO5ZnL9jxHmJSN6-Ue5-kdC-niM6=Jw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAE9FiQVUcYu-KM8fBs3zO5ZnL9jxHmJSN6-Ue5-kdC-niM6=Jw@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, May 15, 2012 at 07:11:34PM -0700, Yinghai Lu wrote:
>> So these steps is done after boot up and user find B3 doesn't work?
>
>yes, after os is booted up.
>
>Yinghai

Yinghai

I think about this issue again, this behavior of kernel will bring some
unconvenience to the user. 

Do you think the kernel could handle this situation?
-- 
Richard Yang
Help you, Help me

